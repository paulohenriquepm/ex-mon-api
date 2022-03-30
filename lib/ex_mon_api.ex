defmodule ExMonApi do
  alias ExMonApi.Modules.Trainer

  defdelegate create_trainer(params), to: Trainer.Create, as: :call
end
