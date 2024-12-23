defmodule AshTest.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [AshTest.Repo]

    opts = [strategy: :one_for_one, name: AshTest.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
