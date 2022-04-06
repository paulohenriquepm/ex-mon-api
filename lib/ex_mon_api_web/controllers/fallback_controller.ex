defmodule ExMonApiWeb.FallbackController do
  use ExMonApiWeb, :controller

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(ExMonApiWeb.ErrorView)
    |> render("unauthorized.json", result: "Trainer unauthorized")
  end

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ExMonApiWeb.ErrorView)
    |> render("bad_request.json", result: result)
  end
end
