defmodule ExMonApi.Schemas.TrainerTest do
  use ExMonApi.DataCase

  alias ExMonApi.Schemas.Trainer

  describe "changeset/1" do
    test "when passing valid params, should returns a valid changeset" do
      params = %{name: "Teste", password: "123456789"}

      result = Trainer.changeset(params)

      assert %Ecto.Changeset{
               changes: %{
                 name: "Teste",
                 password: "123456789"
               },
               valid?: true
             } = result
    end

    test "when passing invalid params, should returns an invalid changeset" do
      params = %{name: "Teste"}

      result = Trainer.changeset(params)

      assert %Ecto.Changeset{
               changes: %{
                 name: "Teste"
               },
               valid?: false
             } = result

      assert errors_on(result) == %{password: ["can't be blank"]}
    end
  end

  describe "build/1" do
    test "when all params are valid, returns a valid trainer struct" do
      params = %{name: "Teste", password: "123456789"}

      result = Trainer.build(params)

      assert {:ok,
              %Trainer{
                name: "Teste",
                password: "123456789"
              }} = result
    end

    test "when params are invalid, returns an error" do
      params = %{name: "Teste"}

      {:error, result} = Trainer.build(params)

      assert %Ecto.Changeset{valid?: false} = result
      assert errors_on(result) == %{password: ["can't be blank"]}
    end
  end
end
