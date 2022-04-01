defmodule ExMonApi.Repositories.Trainer.Creator do
  alias ExMonApi.Repo

  def execute(changeset) do
    Repo.insert(changeset)
  end
end