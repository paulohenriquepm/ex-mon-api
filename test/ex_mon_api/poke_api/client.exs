defmodule ExMonApi.PokeApi.ClientTest do
  use ExUnit.Case

  import Tesla.Mock

  alias ExMonApi.PokeApi.Client

  @base_url "https://pokeapi.co/api/v2/pokemon/"

  describe "get_pokemon_by_name/1" do
    test "when exists a pokemon with given name, it should return the pokemon" do
      pokemon_name = "pikachu"
      mock_response_body = %{"name" => "#{pokemon_name}", "weight" => 60, "types" => ["eletric"]}

      mock(fn %{method: :get, url: @base_url <> ^pokemon_name} ->
        %Tesla.Env{status: 200, body: mock_response_body}
      end)

      result = Client.get_pokemon_by_name(pokemon_name)

      expected_result =
        {:ok, %{"name" => "#{pokemon_name}", "weight" => 60, "types" => ["eletric"]}}

      assert result == expected_result
    end

    test "when does not exist a pokemon with given name, it should return not found" do
      pokemon_name = "wrong-name"

      mock(fn %{method: :get, url: @base_url <> ^pokemon_name} ->
        %Tesla.Env{status: 404}
      end)

      result = Client.get_pokemon_by_name(pokemon_name)

      expected_result = {:error, "Pokemon not found with name: #{pokemon_name}"}

      assert result == expected_result
    end

    test "when an unexpected error occurs, it should return the error" do
      pokemon_name = "pikachu"

      mock(fn %{method: :get, url: @base_url <> ^pokemon_name} ->
        {:error, :timeout}
      end)

      result = Client.get_pokemon_by_name(pokemon_name)

      expected_result = {:error, :timeout}

      assert result == expected_result
    end
  end
end
