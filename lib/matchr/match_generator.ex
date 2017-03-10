defmodule Matchr.MatchGenerator do

  def match_users(skills, available_users), do: match_users(skills, available_users, [])
  def match_users([], available_users, matches), do: {matches, Enum.map(available_users, fn(u) -> u.id end)}
  def match_users(_, [], matches), do: {matches, []}

  def match_users(skills, available_users, matches) do
    [skill | remaining_skills] = skills
    {new_matches, remaining_users} = find_matches_for_skill(skill, available_users)
    updated_matches = matches ++ new_matches
    match_users(remaining_skills, remaining_users, updated_matches)
  end

  defp find_matches_for_skill(skill, available_users) do
    case Enum.filter(skill.teachers, fn(teacher) -> user_is_available(teacher, available_users) end) do
      [] -> {[], available_users}
      available_teachers -> find_matches_for_available_teachers(skill, available_teachers, available_users)
    end
  end

  defp find_matches_for_available_teachers(skill, teachers, available_users) do
    Enum.reduce(teachers, {[], available_users}, fn(teacher, acc) -> find_match_for_available_teacher(skill, teacher, acc, available_users) end)
  end

  defp find_match_for_available_teacher(skill, teacher, acc, available_users) do
    case Enum.filter(skill.learners, fn(student) -> user_is_available(student, available_users) end) do
      [] -> acc
      available_students -> create_match_if_possible(skill, teacher, available_students, acc, available_users)
    end
  end

  defp create_match_if_possible(skill, teacher, available_students, acc, available_users) do
    [student | remaining_students] = available_students
    case student do
      [] -> acc
      _ -> if student != teacher, do: create_match(teacher, student, skill, acc, available_users), else: create_match_if_possible(skill, teacher, remaining_students, acc, available_users)
    end
  end

  defp create_match(teacher, learner, skill, acc, available_users) do
    {current_matches, users} = acc
    remaining_users = Enum.filter(users, fn(user) -> (user.id != teacher.id && user.id != learner.id) end)
    {current_matches ++ [%{teacher_id: teacher.id, learner_id: learner.id, skill_id: skill.id}], remaining_users}
  end

  def sort_skills(skills) do
    Enum.sort_by(skills, &score/1)
  end

  defp user_is_available(user, available_users) do
    available_users
    |> Enum.map(fn(user) -> user.id end)
    |> Enum.member?(user.id)
  end

  defp score(skill) do
    length(skill.teachers) - length(skill.learners)
  end

  def remove_skills_with_no_teachers_or_no_learners(skills) do
    skills
    |> reduce_skills_for_func(&no_teacher/2)
    |> reduce_skills_for_func(&no_learner/2)
  end

  defp reduce_skills_for_func(skills, func) do
    skills
    |> Enum.reduce([], func)
  end

  defp no_teacher(skill, acc) do
    case skill.teachers do
      [] -> acc
      _ -> acc ++ [skill]
    end
  end

  defp no_learner(skill, acc) do
   case skill.learners do
      [] -> acc
      _ -> acc ++ [skill]
    end
  end
end
