defmodule Matchr.MatchGenerator do

  def sort_skills(skills) do
    # Enum.sort_by(skills, &score/1)
    Enum.sort_by(skills, &score/1)
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
