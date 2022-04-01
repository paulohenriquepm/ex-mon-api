defmodule ExMonApi.Modules.Trainer.Delete do
  alias ExMonApi.Repositories.Trainer.Deleter, as: TrainerDeleter
  alias Ecto.UUID

  def call(id) do
    id
    |> UUID.cast()
    |> validates_casted_id()
  end

  defp validates_casted_id(casted_result) do
    case casted_result do
      :error -> "Invalid ID format"
      {:ok, id} -> TrainerDeleter.delete_by_id(id)
    end
  end
end