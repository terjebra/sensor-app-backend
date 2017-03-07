defmodule SensorApi.TemperatureView do
  use SensorApi.Web, :view
  def render("index.json", %{temperatures: temperatures}) do
   render_many(temperatures, SensorApi.TemperatureView, "temperature.json")
  end

  def render("show.json", %{temperature: temperature}) do
    render_one(temperature, SensorApi.TemperatureView, "temperature.json")
  end

  def render("temperature.json", %{temperature: temperature}) do
    %{id: temperature.id,
        reading: String.to_float(temperature.reading),
        date: Ecto.DateTime.to_string(temperature.date)
      }
  end
end
