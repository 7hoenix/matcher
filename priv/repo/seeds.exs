# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Matcher.Repo.insert!(%Matchr.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


import Matcher.DatabaseSeeder

clear

names = ["Turing", "Lovelace", "Dijkstra", "Hopper"]
skill_names = ["sketch", "elixir", "elm", "clojure", "css3"]

users = names |> Enum.map(fn name -> insert_user name end)
skills = skill_names |> Enum.map(fn skill_name -> insert_skill skill_name end)

(1..10) |> Enum.each(fn _ -> insert_user_skill(take_random_from(users), take_random_from(skills)) end)
