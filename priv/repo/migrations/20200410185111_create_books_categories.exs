defmodule App.Repo.Migrations.CreateBooksCategories do
  use Ecto.Migration

  def change do
    create table(:books_categories) do
      add :book_id, references(:books)
      add :category_id, references(:categories)
    end

    create unique_index(:books_categories, [:book_id, :category_id])
  end
end
