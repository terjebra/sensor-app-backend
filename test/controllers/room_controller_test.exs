defmodule SensorApi.RoomControllerTest do
  use SensorApi.ConnCase

  alias SensorApi.Room
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, room_path(conn, :index)
    assert json_response(conn, 200)== []
  end

  test "shows chosen resource", %{conn: conn} do
    room = Repo.insert! %Room{"name": "Room"}
    conn = get conn, room_path(conn, :show, room)
    assert json_response(conn, 200)== %{"id" => room.id,
      "id" => room.id,
      "name" => room.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, room_path(conn, :show, -1)
    end
  end


  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, room_path(conn, :create), @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    room = Repo.insert! %Room {"name": "Room"}
    conn = put conn, room_path(conn, :update, room), @valid_attrs
    assert json_response(conn, 200)["id"]
    assert Repo.get_by(Room, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    room = Repo.insert! %Room{}
    conn = put conn, room_path(conn, :update, room), @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end
end
