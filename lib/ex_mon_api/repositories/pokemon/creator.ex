defmodule ExMonApi.Repositories.Pokemon.Creator do
  alias ExMonApi.Repo

  def execute(changeset) do
    Repo.insert(changeset)
  end
end
