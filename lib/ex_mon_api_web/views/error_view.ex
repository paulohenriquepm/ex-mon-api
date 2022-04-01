defmodule ExMonApiWeb.ErrorView do
  use ExMonApiWeb, :view

  import Ecto.Changeset, only: [traverse_errors: 2]

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("bad_request.json", %{result: %Ecto.Changeset{} = result}) do
    %{message: translate_errors(result)}
  end
  def render("bad_request.json", %{result: message}) do
    %{message: message}
  end

  defp translate_errors(result) do
    traverse_errors(result, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
