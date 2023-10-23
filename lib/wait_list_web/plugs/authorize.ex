defmodule WaitListWeb.Authorize do
  import Plug.Conn
  import Phoenix.Controller
  import WaitList.Authorization

  def init(opts), do: opts

  def call(conn, opts) do
    role = conn.assigns.current_user.role
    resource = Keyword.get(opts, :resource)
    action = action_name(conn)
    IO.puts("Action: #{inspect(action)}")
    IO.puts("Role: #{inspect(role)}")

    check(action, role, resource)
    |> maybe_continue(conn)
  end

  defp maybe_continue(true, conn), do: conn

  defp maybe_continue(false, conn) do
    conn
    |> put_flash(:error, "Você não tem permissão para fazer isto.")
    |> redirect(to: "/parties")
    |> halt()
  end

  defp check(action, role, resource) when action in [:index, :show] do
    can(role) |> read?(resource)
  end

  defp check(action, role, resource) when action in [:edit, :update] do
    can(role) |> update?(resource)
  end

  defp check(action, role, resource) when action in [:new, :create] do
    can(role) |> create?(resource)
  end

  defp check(:delete, role, resource) do
    can(role) |> delete?(resource)
  end

  defp check(_action, _role, _resource), do: false
end
