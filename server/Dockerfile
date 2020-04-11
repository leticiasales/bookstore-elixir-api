FROM elixir:1.7

# Install the Phoenix package and the framework itself
# see: https://hexdocs.pm/phoenix/installation.html
RUN mix local.hex --force && \
    mix local.rebar --force &&\
    mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force

# Installation of the inotify-tools
RUN apt-get update && apt-get install -y \
    inotify-tools \
 && rm -rf /var/lib/apt/lists/*

# make /my_app the current working directory
WORKDIR /app

# expose port 4000
EXPOSE 4000