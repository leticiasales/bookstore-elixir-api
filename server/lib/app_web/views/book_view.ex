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
    %{
      id: book.id,
      cover_url: book.cover_url,
      name: book.name,
      price: book.price,
      summary: book.summary,
      authors: book.authors
    }
  end
end
