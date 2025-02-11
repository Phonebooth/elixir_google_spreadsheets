defmodule GSS do
  @moduledoc """
  Bootstrap Google Spreadsheet application.
  """

  use Application

  def start(_type, _args) do
    IO.inspect(config(:goth_module), label: "GSS: start: config(:goth_module)")

    children = [
      {GSS.Registry, [auth_module: config(:goth_module)]},
      {GSS.Spreadsheet.Supervisor, []},
      {GSS.Client.Supervisor, []}
    ]

    Supervisor.start_link(children, strategy: :one_for_all)
  end

  @doc """
  Read config settings scoped for GSS.
  """
  @spec config(atom(), any()) :: any()
  def config(key, default \\ nil) do
    Application.get_env(:elixir_google_spreadsheets, key, default)
  end
end
