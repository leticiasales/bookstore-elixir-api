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


category = App.Repo.insert! %App.Relations.Category {
  name: "Thriller"
}

author = App.Repo.insert! %App.Relations.Author {
            name: "Robert Kirkman",
            about: "Robert Kirkman is an American comic book writer best known for co-creating The Walking Dead, Invincible, Tech Jacket, Outcast and Oblivion Song for Image Comics, in addition to writing Ultimate X-Men, Irredeemable Ant-Man and Marvel Zombies for Marvel Comics.",
          }

twd = App.Repo.insert! %App.Items.Book {
              summary: "The Walking Dead original novel series, set in the universe of Robert Kirkman's iconic comic book, continues with The Fall of the Governor – Part One. From co-authors Kirkman, creator of the Eisner Award-winning comic as well as executive producer of AMC's blockbuster TV series, and Jay Bonansinga, Stoker Award-finalist and internationally acclaimed author, comes the gripping third novel in this richly woven, page-turning literary saga, which began with The Walking Dead: Rise of the Governor.",
              price: 7.99,
              name: "The Walking Dead: The Fall of the Governor",
              cover_url: "https://upload.wikimedia.org/wikipedia/en/thumb/d/df/Fall_of_the_Governor_Part_one.jpg/220px-Fall_of_the_Governor_Part_one.jpg",
              authors: [author]
            }

App.Repo.preload(twd, :categories) # load the :users for the org
|> App.Items.Book.changeset(%{}) # somehow generate a changeset with no changes
|> Ecto.Changeset.put_assoc(:categories, [category]) # creates the association
|> App.Repo.update()