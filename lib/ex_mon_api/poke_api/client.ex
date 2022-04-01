defmodule ExMonApi.PokeApi.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://pokeapi.co/api/v2/"
  plug Tesla.Middleware.JSON

  def get_pokemon_by_name(name) do
    "/pokemon/#{name}"
    |> get()
    |> handle_response(name)    
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: body}}, _name), do: {:ok, body}
  defp handle_response({:ok, %Tesla.Env{status: 404}}, name), do: {:error, "Pokemon not found with name: #{name}"} 
  defp handle_response({:error, _error} = error, _name), do: error
end