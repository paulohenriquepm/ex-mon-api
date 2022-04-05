defmodule ExMonApi.Modules.Pokemon.Get do
  alias ExMonApi.PokeApi.Client
  alias ExMonApi.Serializers.Pokemon

  def call(name) do
    name
    |> Client.get_pokemon_by_name()
    |> handle_response
  end

  defp handle_response({:ok, body}), do: {:ok, Pokemon.serialize(body)}
  defp handle_response({:error, _error} = error), do: error
end
