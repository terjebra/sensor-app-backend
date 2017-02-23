defmodule SensorApi.TemperatureController do
  use SensorApi.Web, :controller

  alias SensorApi.Temperature

  def index(conn, _params) do
    temperatures = Repo.all(Temperature)
    render(conn, "index.json", temperatures: temperatures)
  end

  def create(conn, temperature_params) do
    changeset = Temperature.changeset(%Temperature{}, temperature_params)

    case Repo.insert(changeset) do
      {:ok, temperature} ->
        SensorApi.TemperatureChannel.broadcast(temperature)
        conn
        |> put_status(:created)
        |> put_resp_header("location", temperature_path(conn, :show, temperature))
        |> render("show.json", temperature: temperature)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SensorApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    temperature = Repo.get!(Temperature, id)
    render(conn, "show.json", temperature: temperature)
  end

  def update(conn, temperature_params) do
    conn = fetch_query_params(conn)
    %{ "id" => id } = conn.params
    temperature = Repo.get!(Temperature, id)
    changeset = Temperature.changeset(temperature, temperature_params)

    case Repo.update(changeset) do
      {:ok, temperature} ->
        render(conn, "show.json", temperature: temperature)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SensorApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    temperature = Repo.get!(Temperature, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(temperature)

    send_resp(conn, :no_content, "")
  end
end
