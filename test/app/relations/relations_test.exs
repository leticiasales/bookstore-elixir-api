defmodule App.RelationsTest do
  use App.DataCase

  alias App.Relations

  describe "authors" do
    alias App.Relations.Author

    @valid_attrs %{about: "some about", name: "some name"}
    @update_attrs %{about: "some updated about", name: "some updated name"}
    @invalid_attrs %{about: nil, name: nil}

    def author_fixture(attrs \\ %{}) do
      {:ok, author} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Relations.create_author()

      author
    end

    test "list_authors/0 returns all authors" do
      author = author_fixture()
      assert Relations.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert Relations.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      assert {:ok, %Author{} = author} = Relations.create_author(@valid_attrs)
      assert author.about == "some about"
      assert author.name == "some name"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Relations.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      assert {:ok, author} = Relations.update_author(author, @update_attrs)
      assert %Author{} = author
      assert author.about == "some updated about"
      assert author.name == "some updated name"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = Relations.update_author(author, @invalid_attrs)
      assert author == Relations.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = Relations.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> Relations.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = Relations.change_author(author)
    end
  end

  describe "categories" do
    alias App.Relations.Category

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Relations.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Relations.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Relations.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Relations.create_category(@valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Relations.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, category} = Relations.update_category(category, @update_attrs)
      assert %Category{} = category
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Relations.update_category(category, @invalid_attrs)
      assert category == Relations.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Relations.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Relations.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Relations.change_category(category)
    end
  end
end
