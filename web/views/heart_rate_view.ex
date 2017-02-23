defmodule SensorApi.HeartRateView do
  use SensorApi.Web, :view

  def render("index.json", %{heart_rates: heart_rates}) do
     render_many(heart_rates, SensorApi.HeartRateView, "heart_rate.json")
  end

  def render("show.json", %{heart_rate: heart_rate}) do
    render_one(heart_rate, SensorApi.HeartRateView, "heart_rate.json")
  end

  def render("heart_rate.json", %{heart_rate: heart_rate}) do
    %{id: heart_rate.id,
      device_id: heart_rate.device_id,
      beat: heart_rate.beat,
      time: Ecto.DateTime.to_time(heart_rate.date),
      date: Ecto.DateTime.to_date(heart_rate.date)
    }
  end
end
