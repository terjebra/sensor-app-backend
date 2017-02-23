defmodule SensorApi.RoomView do
  use SensorApi.Web, :view


  def render("index.json", %{rooms: rooms}) do
    render_many(rooms, SensorApi.RoomView, "room.json")
  end

  def render("show.json", %{room: room}) do
    render_one(room, SensorApi.RoomView, "room.json")
  end

  def render("room.json", %{room: room}) do
    %{id: room.id,
      id: room.id,
      name: room.name}
  end
end
