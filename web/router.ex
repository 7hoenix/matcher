defmodule Matchr.Router do
  use Matchr.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", Matchr do
    pipe_through :browser # Use the default browser stack

    get "/", AppController, :index
  end


  scope "/api", Matchr do
    pipe_through :api

    resources "/users", UserController, only: [:index, :show, :create, :update, :delete]
    resources "/skills", SkillController, only: [:index, :show, :create, :update, :delete]
  end
end
