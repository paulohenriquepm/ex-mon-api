defmodule ExMonApiWeb.Router do
  use ExMonApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ExMonApiWeb.Auth.Pipeline
  end

  scope "/api", ExMonApiWeb do
    pipe_through :api

    post "/trainers", TrainersController, :create
    post "trainers/signin", TrainersController, :sign_in

    # get "/pokemons/:name", PokemonsController, :show
  end

  scope "/api", ExMonApiWeb do
    pipe_through [:api, :auth]

    resources "/trainers", TrainersController, only: [:update, :delete, :show]

    resources "/pokemons", PokemonsController, only: [:create, :update, :delete]
    get "/pokemons/:name", PokemonsController, :show
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ExMonApiWeb.Telemetry
    end
  end
end
