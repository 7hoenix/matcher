defmodule Matchr.MatchesTest do
  use Matchr.ModelCase
  alias Matchr.Matches

  @valid_match_attrs %{
    teacher_id: 9,
    learner_id: 0,
    skill_id: 1,
  }

  describe "insert" do
    test "inserts a match" do
      {code, inserted_match} = Matches.insert(@valid_match_attrs)

      assert code == :ok
      assert inserted_match.teacher_id == 9
      assert inserted_match.learner_id == 0
      assert inserted_match.skill_id == 1
      assert Matches.count == 1
    end

    test "returns error for invalid attributes" do
      {code, _} = Matches.insert(%{})

      assert code == :error
    end
  end

  describe "load" do
    test "returns a match record based on an id" do
      {:ok, inserted_match} = Matches.insert(@valid_match_attrs)

      match = Matches.load(inserted_match.id)

      assert match.id == inserted_match.id
    end

    test "returns nill for invalid id" do
      assert Matches.load(999) == nil
    end
  end

  describe "load_all" do
    test "returns all matches" do
      Matches.insert(@valid_match_attrs)
      Matches.insert(@valid_match_attrs)

      matches = Matches.load_all

      assert length(matches) == 2
    end
  end
end
