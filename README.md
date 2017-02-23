# Real time temperature readings with Elixir and Elm - backend part

Experimenting with Elixir

When a new temperature reading is registered through the API , a push notification is sent the frontend

## Backend

### Docker
* cd elixir/Docker
* docker-compose build
* docker-compose up

### Elixir
 * mix ecto.create
 * mix ecto.migrate
 * mix phoenix.server

### Usage
* Backend
  * GET and POST
  * http://localhost:4000/temperatures