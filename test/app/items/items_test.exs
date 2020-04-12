defmodule App.ItemsTest do
  use App.DataCase

  alias App.Items

  describe "books" do
    alias App.Items.Book

    @valid_attrs %{cover_url: "some cover_url", name: "some name", price: "120.5", summary: "some summary"}
    @update_attrs %{cover_url: "some updated cover_url", name: "some updated name", price: "456.7", summary: "some updated summary"}
    @invalid_attrs %{cover_url: nil, name: nil, price: nil, summary: nil}

    def book_fixture(attrs \\ %{}) do
      {:ok, book} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Items.create_book()

      book
    end

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Items.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Items.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      assert {:ok, %Book{} = book} = Items.create_book(@valid_attrs)
      assert book.cover_url == "some cover_url"
      assert book.name == "some name"
      assert book.price == Decimal.new("120.5")
      assert book.summary == "some summary"
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      assert {:ok, book} = Items.update_book(book, @update_attrs)
      assert %Book{} = book
      assert book.cover_url == "some updated cover_url"
      assert book.name == "some updated name"
      assert book.price == Decimal.new("456.7")
      assert book.summary == "some updated summary"
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_book(book, @invalid_attrs)
      assert book == Items.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Items.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Items.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Items.change_book(book)
    end
  end
end
