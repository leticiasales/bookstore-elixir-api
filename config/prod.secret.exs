use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :app, AppWeb.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# Configure database
config :app, App.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: System.get_env("RDS_DB_NAME"),
  username: System.get_env("RDS_USERNAME"),
  password: System.get_env("RDS_PASSWORD"),
  hostname: System.get_env("RDS_HOSTNAME"),
  port: System.get_env("RDS_PORT") || 5432,
  pool_size: 20,
  ssl: true