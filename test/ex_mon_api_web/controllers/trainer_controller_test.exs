defmodule ExMonApiWeb.Controllers.TrainersControllerTest do
  use ExMonApiWeb.ConnCase

  import ExMonApiWeb.Auth.Guardian

  alias ExMonApi.Schemas.Trainer

  describe "show/2" do
    setup %{conn: conn} do
      params = %{name: "Teste", password: "123456789"}
      {:ok, trainer} = ExMonApi.create_trainer(params)
      {:ok, token, _claims} = encode_and_sign(trainer)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, trainer_id: trainer.id}
    end

    test "when exists a trainer with given id, it should return the trainer", %{
      conn: conn,
      trainer_id: trainer_id
    } do
      result = conn |> get(Routes.trainers_path(conn, :show, trainer_id)) |> json_response(:ok)

      assert %{"id" => id, "inserted_at" => _inserted_at, "name" => "Teste"} = result
    end

    test "when does not exist a trainer with given id, it should return the not found message", %{
      conn: conn
    } do
      wrong_trainer_id = Ecto.UUID.generate()

      result =
        conn
        |> get(Routes.trainers_path(conn, :show, wrong_trainer_id))
        |> json_response(:bad_request)

      assert %{"message" => "Trainer not found with id: #{wrong_trainer_id}"} == result
    end
  end
end
