defmodule WaitList.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()
    field :role, :string, default: "user"
    timestamps()
  end
end
