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

defmodule Alchemapi.Web do
  use Plug.Router
  require Logger

  plug Plug.Logger
  plug :match
  plug :dispatch

  def init(options) do
    options
  end

  def start_link do
    {:ok, _} = Plug.Adapters.Cowboy.http Alchemapi.Web, []
  end

  get "/" do
    conn
    |> send_resp(200, "ok")
    |> halt
  end

  get "/supersecret" do
    conn
    |> send_resp(200, "You've reached the super secret code! The password is: abc123")
    |> halt
  end

  match _ do
    conn
    |> send_resp(404, "Nothing here")
    |> halt
  end
end
