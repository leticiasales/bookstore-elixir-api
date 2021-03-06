FROM elixir:1.7

# Install the Phoenix package and the framework itself
# see: https://hexdocs.pm/phoenix/installation.html
RUN mix local.hex --force
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new.ez

# Installation of the inotify-tools
RUN apt-get update && apt-get install -y \
    inotify-tools \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

# expose port 4000
EXPOSE 4000

CMD ["mix", "phx.server"]