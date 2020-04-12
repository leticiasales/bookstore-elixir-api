defmodule AppWeb.CategoryController do
  use AppWeb, :controller

  alias App.Relations
  alias App.Relations.Category

  action_fallback AppWeb.FallbackController

  def index(conn, _params) do
    categories = Relations.list_categories()
    render(conn, "index.json", categories: categories)
  end

  def create(conn, %{"category" => category_params}) do
    with {:ok, %Category{} = category} <- Relations.create_category(category_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", category_path(conn, :show, category))
      |> render("show.json", category: category)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Relations.get_category!(id)
    render(conn, "show.json", category: category)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Relations.get_category!(id)

    with {:ok, %Category{} = category} <- Relations.update_category(category, category_params) do
      render(conn, "show.json", category: category)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Relations.get_category!(id)
    with {:ok, %Category{}} <- Relations.delete_category(category) do
      send_resp(conn, :no_content, "")
    end
  end
end
