defmodule ExMonApi.Modules.Pokemon.Get do
  alias ExMonApi.PokeApi.Client
  alias ExMonApi.Schemas.Pokemon

  def call(name) do
    name
    |> Client.get_pokemon_by_name()
    |> handle_response
  end

  defp handle_response({:ok, body}), do: {:ok, Pokemon.build(body)}
  defp handle_response({:error, _error} = error), do: error
end
