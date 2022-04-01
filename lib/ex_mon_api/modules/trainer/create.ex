defmodule ExMonApi.Modules.Trainer.Create do
  alias ExMonApi.Repositories.Trainer.Creator, as: TrainerCreator
  alias ExMonApi.Schemas.Trainer

  def call(params) do
    params
    |> Trainer.build()
    |> create_trainer()
  end

  defp create_trainer({:ok, changeset}), do: TrainerCreator.execute(changeset)
  defp create_trainer({:error, _changeset} = error), do: error
end