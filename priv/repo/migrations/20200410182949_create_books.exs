defmodule App.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :name, :string
      add :summary, :text
      add :price, :float
      add :cover_url, :string

      timestamps()
    end

    create unique_index(:books, [:name])
  end
end
