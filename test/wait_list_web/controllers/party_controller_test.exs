defmodule WaitListWeb.PartyControllerTest do
  use WaitListWeb.ConnCase

  import WaitList.ReservationFixtures

  @create_attrs %{name: "some name", size: 42, status: :waiting}
  @update_attrs %{name: "some updated name", size: 43, status: :seated}
  @invalid_attrs %{name: nil, size: nil, status: nil}

  describe "index" do
    setup %{conn: conn} do
      user = %WaitList.Users.User{id: 1, email: "jonhdoe@google.com"}
      authed_conn = Pow.Plug.assign_current_user(conn, user, [])

      {:ok, conn: conn, authed_conn: authed_conn}
    end

    test "lists all parties not logged", %{conn: conn} do
      conn = get(conn, ~p"/session/new")
      assert html_response(conn, 200) =~ "Sign in"
    end
  end

  describe "new party" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/parties/new")
      assert html_response(conn, 302) =~ "You are being"
    end
  end

  describe "create party" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/parties", party: @create_attrs)

      # assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/session/new"

      conn = get(conn, ~p"/parties/#{3}")
      assert html_response(conn, 302) =~ "redirected"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/parties", party: @invalid_attrs)
      assert html_response(conn, 302) =~ "redirected"
    end
  end

  describe "edit party" do
    setup [:create_party]

    test "renders form for editing chosen party", %{conn: conn, party: party} do
      conn = get(conn, ~p"/parties/#{party}/edit")
      assert html_response(conn, 302) =~ "redirected"
    end
  end

  describe "update party" do
    setup [:create_party]

    test "redirects when data is valid not logged", %{conn: conn, party: party} do
      conn = put(conn, ~p"/parties/#{party}", party: @update_attrs)
      assert redirected_to(conn) == ~p"/session/new"

      conn = get(conn, ~p"/parties/#{party}")
      assert html_response(conn, 302) =~ "redirected"
    end

    test "renders errors when data is invalid", %{conn: conn, party: party} do
      conn = put(conn, ~p"/parties/#{party}", party: @invalid_attrs)
      assert html_response(conn, 302) =~ "redirect"
    end
  end

  describe "delete party" do
    setup [:create_party]

    test "deletes chosen party not logged", %{conn: conn, party: party} do
      conn = delete(conn, ~p"/parties/#{party}")
      assert redirected_to(conn) == ~p"/session/new"

      conn = get(conn, ~p"/parties/#{party}")
      assert redirected_to(conn) == ~p"/session/new?request_path=%2Fparties%2F#{party}"
    end
  end

  defp create_party(_) do
    party = party_fixture()
    %{party: party}
  end
end
