# WaitList

App based on video [Authorization in Phoenix web applications using Role Based Access Control (RBAC)](https://www.youtube.com/watch?v=6TlcVk-1Tpc)

![index image](https://github.com/augustoedt/waiting-list-app/blob/main/images/main.png?raw=true "Waiting App!")

![index image](https://github.com/augustoedt/waiting-list-app/blob/main/images/party.png?raw=true "Waiting App!")

Pow, lib for authentication. Phoenix 1.7.7, Elixir 1.14

create database:

```bash
docker run -d --rm --name wait_list -p 5432:5432 -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres postgres
```

run migrations:

```bash
mix ecto.setup
```

run app

```bash
mix phx.server
```