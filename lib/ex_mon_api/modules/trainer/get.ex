defmodule ExMonApi.Modules.Trainer.Get do
  alias ExMonApi.Repositories.Trainer.Finder, as: TrainerFinder
  alias Ecto.UUID

  def call(id) do
    id
    |> UUID.cast()
    |> validates_casted_id()
  end

  defp validates_casted_id(casted_result) do
    case casted_result do
      :error -> {:error, "Invalid ID format"}
      {:ok, id} -> TrainerFinder.find_by_id(id)
    end
  end
end