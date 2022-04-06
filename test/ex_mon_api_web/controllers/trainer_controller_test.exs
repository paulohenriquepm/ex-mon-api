defmodule ExMonApiWeb.Controllers.TrainersControllerTest do
  use ExMonApiWeb.ConnCase

  alias ExMonApi.Schemas.Trainer

  describe "show/2" do
    test "when exists a trainer with given id, it should return the trainer", %{conn: conn} do
      params = %{name: "Teste", password: "123456789"}
      {:ok, %Trainer{id: id}} = ExMonApi.create_trainer(params)

      result = conn |> get(Routes.trainers_path(conn, :show, id)) |> json_response(:ok)

      assert %{"id" => id, "inserted_at" => _inserted_at, "name" => "Teste"} = result
    end

    test "when does not exist a trainer with given id, it should return the not found message", %{
      conn: conn
    } do
      trainer_id = Ecto.UUID.generate()

      result =
        conn |> get(Routes.trainers_path(conn, :show, trainer_id)) |> json_response(:bad_request)

      assert %{"message" => "Trainer not found with id: #{trainer_id}"} == result
    end
  end
end
