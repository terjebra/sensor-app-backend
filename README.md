# Real time temperature readings with Elixir and Elm - backend part

Experimenting with Elixir

When a new temperature reading is registered through the API, a push notification is sent the frontend

![Build Status](https://travis-ci.org/terjebra/sensor-app-backend.svg?branch=master)

## Backend

# API   
* GET and POST
  * http://localhost:4000/temperatures
# Docker
* cd elixir/Docker
* docker-compose build
* docker-compose up

# Usage
* mix ecto.create
* mix ecto.migrate
* mix phoenix.server
