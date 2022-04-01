defmodule ExMonApi do
  alias ExMonApi.Modules.Trainer

  defdelegate create_trainer(params), to: Trainer.Create, as: :call
  defdelegate delete_trainer(id), to: Trainer.Delete, as: :call
  defdelegate get_trainer(id), to: Trainer.Get, as: :call
end
