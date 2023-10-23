defmodule WaitList.Repo.Migrations.UpdateUserAddRole do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role, :string, null: false, default: "user"
    end
  end
end
