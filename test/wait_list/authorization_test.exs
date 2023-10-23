defmodule WaitList.AuthorizationTest do
  use ExUnit.Case
  import WaitList.Authorization, except: [can: 1]
  alias WaitList.Reservation.Party

  def can(:user = role) do
    grant(role)
    |> read(Party)
    |> create(Party)
  end

  test "role can read resource" do
    assert can(:user) |> read?(Party)
  end

  test "role can create resource" do
    assert can(:user) |> create?(Party)
  end

  test "role can not update resource" do
    refute can(:user) |> update?(Party)
  end

  test "role can not delete resource" do
    refute can(:user) |> delete?(Party)
  end
end
