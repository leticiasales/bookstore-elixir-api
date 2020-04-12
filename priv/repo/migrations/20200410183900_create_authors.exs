defmodule App.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :name, :string
      add :about, :text
      add :book_id, references(:books, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:authors, [:name])
  end
end
