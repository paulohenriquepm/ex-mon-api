defmodule ExMonApi.Schemas.Pokemon do
  use Ecto.Schema

  import Ecto.Changeset

  alias ExMonApi.Schemas.Trainer

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "pokemons" do
    field :name, :string
    field :nickname, :string
    field :weight, :string
    field :types, {:array, :string}
    belongs_to(:trainer, Trainer)
    timestamps()
  end

  @required_params [:name, :nickname, :weight, :types, :trainer_id]
  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params), do: create_changeset(%__MODULE__{}, params)
  def changeset(pokemon, params), do: create_changeset(pokemon, params)

  defp create_changeset(pokemon, params) do
    pokemon
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:nickname, min: 2)
  end
end
