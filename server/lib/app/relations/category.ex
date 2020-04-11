defmodule App.Relations.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias App.Items.Book

  schema "categories" do
    field :name, :string
    many_to_many :books, Book, join_through: "books_categories"

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
