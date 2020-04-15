defmodule AppWeb.BookControllerTest do
  use AppWeb.ConnCase

  alias App.Items
  alias App.Items.Book

  @create_attrs %{cover_url: "some cover_url", name: "some name", price: "120.5", summary: "some summary", authors: [], categories: []}
  @update_attrs %{cover_url: "some updated cover_url", name: "some updated name", price: 456.7, summary: "some updated summary", authors: [], categories: []}
  @invalid_attrs %{cover_url: nil, name: nil, price: nil, summary: nil}

  def fixture(:book) do
    {:ok, book} = Items.create_book(@create_attrs)
    book
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all books", %{conn: conn} do
      conn = get conn, book_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create book" do
    test "renders book when data is valid", %{conn: conn} do
      conn = post conn, book_path(conn, :create), book: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, book_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "cover_url" => "some cover_url",
        "name" => "some name",
        "price" => 120.5,
        "summary" => "some summary",
        "authors" => [],
        "categories" => []}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, book_path(conn, :create), book: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update book" do
    setup [:create_book]

    test "renders book when data is valid", %{conn: conn, book: %Book{id: id} = book} do
      conn = put conn, book_path(conn, :update, book), book: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, book_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "cover_url" => "some updated cover_url",
        "name" => "some updated name",
        "price" => 456.7,
        "summary" => "some updated summary",
        "authors" => [],
        "categories" => []}
    end

    test "renders errors when data is invalid", %{conn: conn, book: book} do
      conn = put conn, book_path(conn, :update, book), book: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete book" do
    setup [:create_book]

    test "deletes chosen book", %{conn: conn, book: book} do
      conn = delete conn, book_path(conn, :delete, book)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, book_path(conn, :show, book)
      end
    end
  end

  defp create_book(_) do
    book = fixture(:book)
    {:ok, book: book}
  end
end
