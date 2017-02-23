defmodule SensorApi.HeartRateTest do
  use SensorApi.ModelCase

  alias SensorApi.HeartRate

  @valid_attrs %{beat: "some content", date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, device_id: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = HeartRate.changeset(%HeartRate{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = HeartRate.changeset(%HeartRate{}, @invalid_attrs)
    refute changeset.valid?
  end
end
