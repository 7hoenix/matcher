defmodule Matchr.Router do
  use Matchr.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Matchr do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/skills", SkillController, only: [:index]
  end
end
