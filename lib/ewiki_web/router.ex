defmodule EwikiWeb.Router do
  use EwikiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EwikiWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/status/:message", PageController, :status
    get "/show/:page", PageController, :show

    post "/edit", PageController, :edit
    post "/save", PageController, :save


  end

  # Other scopes may use custom stacks.
  # scope "/api", EwikiWeb do
  #   pipe_through :api
  # end
end
