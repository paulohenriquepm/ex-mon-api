defmodule ExMonApi.Repositories.Trainer.Finder do
  alias ExMonApi.Repo
  alias ExMonApi.Schemas.Trainer

  def find_by_id(id) do
    Repo.get(Trainer, id)
  end
end