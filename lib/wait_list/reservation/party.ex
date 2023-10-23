# import Ecto.Enum
# defenum PartyStatus, waiting: 0, seated: 1, cancelled: 2

defmodule WaitList.Reservation.Party do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parties" do
    field :name, :string
    field :size, :integer
    field :status, Ecto.Enum, values: [waiting: 0, seated: 1, cancelled: 2], default: :waiting

    timestamps()
  end

  @doc false
  def changeset(party, attrs) do
    party
    |> cast(attrs, [:name, :size, :status])
    |> validate_required([:name, :size, :status])
  end
end
