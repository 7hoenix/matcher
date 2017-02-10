defmodule Matchr.Router do
  use Matchr.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Matchr do
    pipe_through :api

    resources "/users", UserController, only: [:index, :show, :create, :update, :delete]
    resources "/skills", SkillController, only: [:index, :show, :create, :update, :delete]
  end
end
