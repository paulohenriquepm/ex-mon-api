defmodule ExMonApiWeb.Auth.Guardian do
  use Guardian, otp_app: :ex_mon_api

  alias ExMonApi.Repositories.Trainer.Finder, as: TrainerFinder

  def subject_for_token(trainer, _claims) do
    sub = to_string(trainer.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> ExMonApi.get_trainer()
  end

  def authenticate(%{"id" => trainer_id, "password" => password}) do
    case TrainerFinder.find_by_id(trainer_id) do
      {:error, error} -> {:error, error}
      trainer -> validate_password(trainer, password)
    end
  end

  defp validate_password({:ok, trainer}, password) do
    case Argon2.verify_pass(password, trainer.password_hash) do
      true -> create_token(trainer)
      false -> {:error, :unauthorized}
    end
  end

  defp create_token(trainer) do
    {:ok, token, _claims} = encode_and_sign(trainer)
    {:ok, token}
  end
end
