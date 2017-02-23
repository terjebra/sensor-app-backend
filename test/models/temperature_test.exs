defmodule SensorApi.TemperatureTest do
  use SensorApi.ModelCase

  alias SensorApi.Temperature

  @valid_attrs %{date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, reading: "21"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Temperature.changeset(%Temperature{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Temperature.changeset(%Temperature{}, @invalid_attrs)
    refute changeset.valid?
  end
end
