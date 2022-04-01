defmodule ExMonApi.Repositories.Trainer.Finder do
  alias ExMonApi.Repo
  alias ExMonApi.Schemas.Trainer

  def find_by_id(id) do
    case Repo.get(Trainer, id) do
      nil -> {:error, "Trainer not found with id: #{id}"}
      found_trainer -> {:ok, found_trainer}
    end
  end
end