defmodule ExMonApi do
  alias ExMonApi.Modules.{Pokemon, Trainer}

  defdelegate create_trainer(params), to: Trainer.Create, as: :call
  defdelegate delete_trainer(id), to: Trainer.Delete, as: :call
  defdelegate get_trainer(id), to: Trainer.Get, as: :call
  defdelegate update_trainer(params), to: Trainer.Update, as: :call

  defdelegate get_pokemon(name), to: Pokemon.Get, as: :call
  defdelegate create_pokemon(params), to: Pokemon.Create, as: :call
end
