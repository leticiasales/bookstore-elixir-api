defmodule App.Items.Book do
  use Ecto.Schema
  import Ecto.Changeset
  alias App.Relations.Author
  alias App.Relations.Category

  schema "books" do
    field :cover_url, :string
    field :name, :string
    field :price, :float
    field :summary, :string
    has_many :authors, Author, on_replace: :nilify
    many_to_many :categories, Category, join_through: "books_categories", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:name, :summary, :price, :cover_url])
    |> cast_assoc(:categories)
    |> cast_assoc(:authors)
    |> validate_required([:name, :summary, :price, :cover_url])
    |> unique_constraint(:name)
  end
end

## def cast_assoc(changeset, name, opts) when is_atom(name) 
