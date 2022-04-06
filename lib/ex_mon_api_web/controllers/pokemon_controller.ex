defmodule ExMonApiWeb.PokemonsController do
  use ExMonApiWeb, :controller

  action_fallback ExMonApiWeb.FallbackController

  def create(conn, params) do
    params
    |> ExMonApi.create_pokemon()
    |> handle_create_response(conn, "create.json", :created)
  end

  def show(conn, %{"name" => name}) do
    name
    |> ExMonApi.get_pokemon()
    |> handle_show_response(conn)
  end

  defp handle_create_response({:ok, pokemon}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, pokemon: pokemon)
  end

  defp handle_create_response({:error, _pokemon} = error, _conn, _view, _status), do: error

  defp handle_show_response({:ok, pokemon}, conn) do
    conn
    |> put_status(:ok)
    |> json(pokemon)
  end

  defp handle_show_response({:error, _pokemon} = error, _conn), do: error
end
