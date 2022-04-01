defmodule ExMonApiWeb.TrainersController do
  use ExMonApiWeb, :controller

  action_fallback ExMonApiWeb.FallbackController

  def create(conn, params) do
    params
    |> ExMonApi.create_trainer()
    |> handle_response(conn, "create.json", :created)
  end

  def delete(conn, %{"id" => id}) do
    id
    |> ExMonApi.delete_trainer()
    |> handle_delete(conn)
  end

  def show(conn, %{"id" => id}) do
    id 
    |> ExMonApi.get_trainer()
    |> handle_response(conn, "show.json", :ok)
  end

  def update(conn, params) do
    params
    |> ExMonApi.update_trainer()
    |> handle_response(conn, "update.json", :ok)
  end


  defp handle_response({:ok, trainer}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, trainer: trainer)
  end
  defp handle_response({:error, _trainer} = error, _conn, _view, _status), do: error

  defp handle_delete({:ok, _trainer}, conn) do
    conn
    |> put_status(:no_content)
    |> text("")
  end
  defp handle_delete({:error, _error} = error, _conn), do: error
end