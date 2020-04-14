# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     App.Repo.insert!(%App.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

import Ecto.Query, warn: false

alias App.Repo
alias App.Items.Book
alias App.Relations.Category
alias App.Relations.Author

categories = [
  %Category{
    name: "Thriller"
  },
  %Category{
    name: "Horror fiction"
  },
  %Category{
    name: "Novel"
  },
  %Category{
    name: "Suspense"
  },
  %Category{
    name: "Psychology"
  }
]

Enum.each(categories, fn(c) ->
  App.Repo.insert!(c)
end)

authors = [
  %Author{
    name: "Robert Kirkman",
    about: "Robert Kirkman is an American comic book writer best known for co-creating The Walking Dead, Invincible, Tech Jacket, Outcast and Oblivion Song for Image Comics, in addition to writing Ultimate X-Men, Irredeemable Ant-Man and Marvel Zombies for Marvel Comics.",
  },
  %Author{
    name: "Jay Bonansinga",
    about: "Jay Bonansinga is an American writer and director. He has written a number of fiction and non-fiction works, co-wrote the novels based on The Walking Dead comics series, including The Walking Dead: Rise of the Governor and The Walking Dead: The Road to Woodbury, among others.",
  },
  %Author{
    name: "A. S. A. Harrison",
    about: "Susan Harrison was a Canadian writer and artist who published under the name A. S. A. Harrison. She lived in Toronto and was married to visual artist John Massey. Harrison made a name for herself with performance art in the late 1960s, collaborating with Margaret Dragu.",
  },
  %Author{
    name: "Daniel Goleman",
    about: "Daniel Goleman is an author and science journalist. For twelve years, he wrote for The New York Times, reporting on the brain and behavioral sciences.",
  }
]

Enum.each(authors, fn(a) ->
  App.Repo.insert!(a)
end)

books = [
  %{
    summary: "The Walking Dead original novel series, set in the universe of Robert Kirkman's iconic comic book, continues with The Fall of the Governor – Part One. From co-authors Kirkman, creator of the Eisner Award-winning comic as well as executive producer of AMC's blockbuster TV series, and Jay Bonansinga, Stoker Award-finalist and internationally acclaimed author, comes the gripping third novel in this richly woven, page-turning literary saga, which began with The Walking Dead: Rise of the Governor.",
    price: 7.99,
    name: "The Walking Dead: The Fall of the Governor",
    cover_url: "https://upload.wikimedia.org/wikipedia/en/thumb/d/df/Fall_of_the_Governor_Part_one.jpg/220px-Fall_of_the_Governor_Part_one.jpg",
    authors: ["Robert Kirkman", "Jay Bonansinga"],
    categories: ["Thriller", "Horror fiction"]
  },
  %{
    summary: "Jodi and Todd are at a bad place in their marriage. Both are at the mercy of their unrelenting wants and needs, and both are unaware that the path they are on is careening toward murder.",
    price: 6,
    name: "The Silent Wife",
    cover_url: "https://prodimage.images-bn.com/pimages/9780594016298_p0_v1_s550x406.jpg",
    authors: ["A. S. A. Harrison"],
    categories: ["Thriller", "Novel", "Suspense"]
  },
  %{
    summary: "Emotional intelligence is the innate potential to feel, use, communicate, recognize, remember, describe, learn from, manage, understand, and explain emotions. Introducing Emotional Intelligence teaches the reader how to become more aware of his or her own emotions, and shows how being more aware of others emotions can improve personal and professional relationships.",
    price: 8,
    name: "Emotional Intelligence",
    cover_url: "https://prodimage.images-bn.com/pimages/9781606712788_p0_v1_s550x406.jpg",
    authors: ["Daniel Goleman"],
    categories: ["Psychology"]
  }
]

Enum.each(books, fn(b) ->
  authors = Repo.all(from a in Author, where: a.name in ^b.authors)
  categories = Repo.all(from c in Category, where: c.name in ^b.categories)

  %Book{}
  |> Book.changeset(Map.drop(b, [:authors, :categories]))
  |> Ecto.Changeset.put_assoc(:authors, authors)
  |> Ecto.Changeset.put_assoc(:categories, categories)
  |> Repo.insert!
end)