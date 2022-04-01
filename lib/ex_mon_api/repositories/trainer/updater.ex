defmodule ExMonApi.Repositories.Trainer.Updater do
  alias ExMonApi.Repositories.Trainer.Finder, as: TrainerFinder
  alias ExMonApi.Schemas.Trainer
  alias ExMonApi.Repo

  def execute(id, params) do
    case TrainerFinder.find_by_id(id) do
      {:error, error} -> {:error, error}
      {:ok, found_trainer} -> update_trainer(found_trainer, params)
    end
  end

  defp update_trainer(trainer, params) do
    trainer
    |> Trainer.changeset(params)
    |> Repo.update()
  end
end