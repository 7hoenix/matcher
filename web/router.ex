defmodule Matcher.Router do
  use Matcher.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Matcher do
    pipe_through :api

    get "/dashboard", DashboardController, :dashboard
    resources "/skills", SkillController, only: [:index]
  end
end
