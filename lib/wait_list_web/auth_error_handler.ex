defmodule WaitListWeb.AuthErrorHandler do
  use WaitListWeb, :controller
  alias Plug.Conn

  @spec call(Conn.t(), atom()) :: Conn.t()
  def call(conn, :not_authenticated) do
    conn
    |> put_flash(:error, "Você precisa estar logado para acessar essa página")
    |> redirect(to: ~p"/session/new")
  end

  @spec call(Conn.t(), atom()) :: Conn.t()
  def call(conn, :already_authenticated) do
    conn
    |> put_flash(:error, "Você já está logado")
    |> redirect(to: ~p"/")
  end
end
