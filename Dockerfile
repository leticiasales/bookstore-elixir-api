FROM elixir:1.7

# Install the Phoenix package and the framework itself
# see: https://hexdocs.pm/phoenix/installation.html
RUN mix local.hex --force && \
    mix local.rebar --force &&\
    mix archive.install hex phx_new 1.4.16 -y

# Installation of the inotify-tools
RUN apt-get update && apt-get install -y \
    inotify-tools \
 && rm -rf /var/lib/apt/lists/*

# make /app the current working directory
WORKDIR /app

# expose port 4000
EXPOSE 4000

CMD ["mix", "phx.server"]