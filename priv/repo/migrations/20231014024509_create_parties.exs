defmodule WaitList.Repo.Migrations.CreateParties do
  use Ecto.Migration

  def change do
    create table(:parties) do
      add :name, :string
      add :size, :integer
      add :status, :string, default: "waiting"

      timestamps()
    end
  end
end
