defmodule WaitListWeb.PartyController do
  use WaitListWeb, :controller

  alias WaitList.Reservation
  alias WaitList.Reservation.Party

  plug WaitListWeb.Authorize, resource: WaitList.Reservation.Party

  def index(conn, _params) do
    parties = Reservation.list_parties()
    changeset = Reservation.change_party(%Party{})
    render(conn, :index, parties: parties, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Reservation.change_party(%Party{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"party" => party_params}) do
    parties = Reservation.list_parties()

    case Reservation.create_party(party_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Reserva criada com sucesso.")
        # |> redirect(to: ~p"/parties/#{party}")
        |> redirect(to: ~p"/parties")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :index, parties: parties, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    try do
      Reservation.get_party!(id)
    rescue
      _ in Ecto.NoResultsError ->
        conn
        |> put_flash(:error, "Não foi possivel encontrar a reserva.")
        |> redirect(to: ~p"/parties")
    else
      party ->
        render(conn, :show, party: party)
    end
  end

  def edit(conn, %{"id" => id}) do
    party = Reservation.get_party!(id)
    changeset = Reservation.change_party(party)
    render(conn, :edit, party: party, changeset: changeset)
  end

  def update(conn, %{"id" => id, "party" => party_params}) do
    party = Reservation.get_party!(id)

    case Reservation.update_party(party, party_params) do
      {:ok, party} ->
        conn
        |> put_flash(:info, "Reserva atualizada com sucesso.")
        |> redirect(to: ~p"/parties/#{party}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, party: party, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    party = Reservation.get_party!(id)
    {:ok, _party} = Reservation.delete_party(party)

    conn
    |> put_flash(:info, "Reserva apagada com sucesso.")
    |> redirect(to: ~p"/parties")
  end
end
