defmodule AppWeb.AuthorController do
  use AppWeb, :controller

  alias App.Relations
  alias App.Relations.Author

  action_fallback AppWeb.FallbackController

  def index(conn, _params) do
    authors = Relations.list_authors()
    render(conn, "index.json", authors: authors)
  end

  def create(conn, %{"author" => author_params}) do
    with {:ok, %Author{} = author} <- Relations.create_author(author_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", author_path(conn, :show, author))
      |> render("show.json", author: author)
    end
  end

  def show(conn, %{"id" => id}) do
    author = Relations.get_author!(id)
    render(conn, "show.json", author: author)
  end

  def update(conn, %{"id" => id, "author" => author_params}) do
    author = Relations.get_author!(id)

    with {:ok, %Author{} = author} <- Relations.update_author(author, author_params) do
      render(conn, "show.json", author: author)
    end
  end

  def delete(conn, %{"id" => id}) do
    author = Relations.get_author!(id)
    with {:ok, %Author{}} <- Relations.delete_author(author) do
      send_resp(conn, :no_content, "")
    end
  end
end
