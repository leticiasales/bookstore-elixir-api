defmodule AppWeb.BookView do
  use AppWeb, :view
  alias AppWeb.BookView

  def render("index.json", %{books: books}) do
    %{data: render_many(books, BookView, "book.json")}
  end

  def render("show.json", %{book: book}) do
    %{data: render_one(book, BookView, "book.json")}
  end

  def render("book.json", %{book: book}) do
    authors = render_many(book.authors, AppWeb.AuthorView, "author.json")
    categories = render_many(book.categories, AppWeb.CategoryView, "category.json")

    %{
      id: book.id,
      cover_url: book.cover_url,
      name: book.name,
      price: book.price,
      authors: authors,
      categories: categories
    }
  end
end
