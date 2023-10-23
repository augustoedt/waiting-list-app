defmodule WaitList.ReservationTest do
  use WaitList.DataCase

  alias WaitList.Reservation

  describe "parties" do
    alias WaitList.Reservation.Party

    import WaitList.ReservationFixtures

    @invalid_attrs %{name: nil, size: nil, status: nil}

    test "list_parties/0 returns all parties" do
      party = party_fixture()
      assert Reservation.list_parties() == [party]
    end

    test "get_party!/1 returns the party with given id" do
      party = party_fixture()
      assert Reservation.get_party!(party.id) == party
    end

    test "create_party/1 with valid data creates a party" do
      valid_attrs = %{name: "some name", size: 42, status: :waiting}

      assert {:ok, %Party{} = party} = Reservation.create_party(valid_attrs)
      assert party.name == "some name"
      assert party.size == 42
      assert party.status == :waiting
    end

    test "create_party/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reservation.create_party(@invalid_attrs)
    end

    test "update_party/2 with valid data updates the party" do
      party = party_fixture()
      update_attrs = %{name: "some updated name", size: 43, status: :cancelled}

      assert {:ok, %Party{} = party} = Reservation.update_party(party, update_attrs)
      assert party.name == "some updated name"
      assert party.size == 43
      assert party.status == :cancelled
    end

    test "update_party/2 with invalid data returns error changeset" do
      party = party_fixture()
      assert {:error, %Ecto.Changeset{}} = Reservation.update_party(party, @invalid_attrs)
      assert party == Reservation.get_party!(party.id)
    end

    test "delete_party/1 deletes the party" do
      party = party_fixture()
      assert {:ok, %Party{}} = Reservation.delete_party(party)
      assert_raise Ecto.NoResultsError, fn -> Reservation.get_party!(party.id) end
    end

    test "change_party/1 returns a party changeset" do
      party = party_fixture()
      assert %Ecto.Changeset{} = Reservation.change_party(party)
    end
  end
end
