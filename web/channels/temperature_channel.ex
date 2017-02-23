defmodule SensorApi.TemperatureChannel do
  use Phoenix.Channel
  require Logger

  intercept(["registered"])
  
  def join("temperature", msg, socket) do
    {:ok, socket}
  end

  def handle_out("registered", payload, socket) do
    push socket, "registered", payload
    {:noreply, socket}
  end

  def broadcast(temperature) do
    Logger.debug temperature.reading
    payload = %{
      id: temperature.id,
      reading: String.to_float(temperature.reading),
      date: temperature.date
    }

    SensorApi.Endpoint.broadcast("temperature", "registered", payload)
  end

end