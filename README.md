# Boostore's Elixir API

## Getting Started

These instructions will cover usage information and for the docker container 

### Prerequisities

In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

### Usage

#### Build

```shell
docker-compose build
```

Create and seed database.

```shell
docker-compose run --rm api mix ecto.setup
```

Start api container on background

```shell
docker-compose up -d
```

Now go to [client repository][https://github.com/leticiasales/bookstore-vue-client] and follow the instructions.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

* People you want to thank
* If you took a bunch of code from somewhere list it here