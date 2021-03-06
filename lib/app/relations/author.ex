defmodule App.Relations.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias App.Items.Book

  schema "authors" do
    field :about, :string
    field :name, :string
    belongs_to :book, Items.Book

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name, :about, :book_id])
    |> validate_required([:name, :about])
    |> unique_constraint(:name)
  end
end
