defmodule ExMonApi.Modules.Trainer.Update do
  alias ExMonApi.Repositories.Trainer.Updater, as: TrainerUpdater
  alias Ecto.UUID

  def call(%{"id" => id} = params) do
    id
    |> UUID.cast()
    |> validates_casted_id()
    |> TrainerUpdater.execute(params)
  end

  defp validates_casted_id(casted_result) do
    case casted_result do
      :error -> {:error, "Invalid ID format"}
      {:ok, id} -> id
    end
  end
end