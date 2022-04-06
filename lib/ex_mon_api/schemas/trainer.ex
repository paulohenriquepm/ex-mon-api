defmodule ExMonApi.Schemas.Trainer do
  use Ecto.Schema

  import Ecto.Changeset

  alias ExMonApi.Schemas.Pokemon

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "trainers" do
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    has_many(:pokemon, Pokemon)
    timestamps()
  end

  @required_params [:name, :password]
  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params), do: create_changeset(%__MODULE__{}, params)
  def changeset(trainer, params), do: create_changeset(trainer, params)

  defp create_changeset(trainer, params) do
    trainer
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 8)
    |> encrypt_password()
  end

  defp encrypt_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp encrypt_password(changeset), do: changeset
end
