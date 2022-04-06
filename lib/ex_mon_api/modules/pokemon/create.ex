defmodule ExMonApi.Modules.Pokemon.Create do
  alias ExMonApi.PokeApi.Client
  alias ExMonApi.Repositories.Pokemon.Creator, as: PokemonCreator
  alias ExMonApi.Schemas.Pokemon, as: PokemonSchema
  alias ExMonApi.Serializers.Pokemon, as: PokemonSerializer

  def call(%{"name" => name} = params) do
    name
    |> Client.get_pokemon_by_name()
    |> handle_response(params)
  end

  defp handle_response({:ok, body}, params) do
    body
    |> PokemonSerializer.serialize()
    |> build_pokemon(params)
    |> create_pokemon()
  end

  defp handle_response({:error, _error} = error, _params), do: error

  defp build_pokemon(%PokemonSerializer{name: name, weight: weight, types: types}, %{
         "nickname" => nickname,
         "trainer_id" => trainer_id
       }) do
    params_to_build = %{
      name: name,
      weight: weight,
      types: types,
      nickname: nickname,
      trainer_id: trainer_id
    }

    params_to_build
    |> PokemonSchema.build()
  end

  defp create_pokemon({:ok, changeset}), do: PokemonCreator.execute(changeset)
  defp create_pokemon({:error, _changeset} = error), do: error
end
