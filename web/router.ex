defmodule SensorApi.Router do
  use SensorApi.Web, :router

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

  scope "/", SensorApi do
    pipe_through :browser # Use the default browser stack
  end


  scope "/api", SensorApi do
    pipe_through :api
    resources "/temperatures", TemperatureController
    resources "/heartrates", HeartRateController
    resources "/rooms", RoomController, except: [:delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", SensorApi do
  #   pipe_through :api
  # end
end
