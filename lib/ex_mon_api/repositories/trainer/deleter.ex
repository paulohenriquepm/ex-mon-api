defmodule ExMonApi.Repositories.Trainer.Deleter do
  alias ExMonApi.Repositories.Trainer.Finder, as: TrainerFinder
  alias ExMonApi.Repo

  def delete_by_id(id) do
    case TrainerFinder.find_by_id(id) do
      nil -> {:error, "Trainer not found with id: #{id}"}
      found_trainer -> Repo.delete(found_trainer)
    end
  end
end