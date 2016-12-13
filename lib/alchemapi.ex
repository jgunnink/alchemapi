defmodule Alchemapi.Api do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Alchemapi.Web, [])
    ]

    opts = [strategy: :one_for_one, name: Alchemapi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
