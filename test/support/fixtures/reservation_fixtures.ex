defmodule WaitList.ReservationFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WaitList.Reservation` context.
  """

  @doc """
  Generate a party.
  """
  def party_fixture(attrs \\ %{}) do
    {:ok, party} =
      attrs
      |> Enum.into(%{
        name: "some name",
        size: 42,
        status: :waiting
      })
      |> WaitList.Reservation.create_party()

    party
  end
end
