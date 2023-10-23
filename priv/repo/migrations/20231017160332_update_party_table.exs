defmodule WaitList.Repo.Migrations.UpdatePartyTable do
  use Ecto.Migration

  def change do
    alter table(:parties) do
      remove :status
      add :status, :integer, default: 0
    end
  end
end
