defmodule SensorApi.HeartRateControllerTest do
  use SensorApi.ConnCase

  alias SensorApi.HeartRate
  @valid_attrs %{beate: "some content", date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, device_id: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, heart_rate_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    heart_rate = Repo.insert! %HeartRate{}
    conn = get conn, heart_rate_path(conn, :show, heart_rate)
    assert json_response(conn, 200)["data"] == %{"id" => heart_rate.id,
      "device_id" => heart_rate.device_id,
      "beate" => heart_rate.beate,
      "date" => heart_rate.date}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, heart_rate_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, heart_rate_path(conn, :create), heart_rate: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(HeartRate, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, heart_rate_path(conn, :create), heart_rate: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    heart_rate = Repo.insert! %HeartRate{}
    conn = put conn, heart_rate_path(conn, :update, heart_rate), heart_rate: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(HeartRate, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    heart_rate = Repo.insert! %HeartRate{}
    conn = put conn, heart_rate_path(conn, :update, heart_rate), heart_rate: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    heart_rate = Repo.insert! %HeartRate{}
    conn = delete conn, heart_rate_path(conn, :delete, heart_rate)
    assert response(conn, 204)
    refute Repo.get(HeartRate, heart_rate.id)
  end
end
