defmodule SensorApi.TemperatureControllerTest do
  use SensorApi.ConnCase
  use Timex

  alias SensorApi.Temperature
  @valid_attrs %{date: Timex.parse!("2015-06-24T04:50:34Z", "{ISO:Extended:Z}"), reading: "36.1"}
  @invalid_attrs %{reading: 0}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, temperature_path(conn, :index)
    assert json_response(conn, 200) == []
  end

  test "shows chosen resource", %{conn: conn} do
    date = "2015-06-24T04:50:34Z"
    temperature = Repo.insert! %Temperature{"date": Timex.parse!(date, "{ISO:Extended:Z}"), reading: "36.1"}
    conn = get conn, temperature_path(conn, :show, temperature)
    assert json_response(conn, 200) == %{"id" => temperature.id,
      "id" => temperature.id,
      "reading" => String.to_float(temperature.reading),
      "date" => date
    }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, temperature_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, temperature_path(conn, :create), @valid_attrs
    assert json_response(conn, 201)["id"]
    assert Repo.get_by(Temperature, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, temperature_path(conn, :create),  @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    date = "2015-06-24T04:50:34Z"
    temperature =  Repo.insert! %Temperature{"date": Timex.parse!(date, "{ISO:Extended:Z}"), reading: "36.1"}
    conn = put conn, temperature_path(conn, :update, temperature),  @valid_attrs
    assert json_response(conn, 200)["id"]
    assert Repo.get_by(Temperature, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    date = "2015-06-24T04:50:34Z"
    temperature =  Repo.insert! %Temperature{"date": Timex.parse!(date, "{ISO:Extended:Z}"), reading: "36.1"}
    conn = put conn, temperature_path(conn, :update, temperature), @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    temperature = Repo.insert! %Temperature{}
    conn = delete conn, temperature_path(conn, :delete, temperature)
    assert response(conn, 204)
    refute Repo.get(Temperature, temperature.id)
  end
end
