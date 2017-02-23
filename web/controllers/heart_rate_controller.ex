defmodule SensorApi.HeartRateController do
  use SensorApi.Web, :controller

  alias SensorApi.HeartRate

  def index(conn, _params) do
    heart_rates = Repo.all(HeartRate)
    render(conn, "index.json", heart_rates: heart_rates)
  end

  def create(conn, heart_rate_params) do
    changeset = HeartRate.changeset(%HeartRate{}, heart_rate_params)

    case Repo.insert(changeset) do
      {:ok, heart_rate} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", heart_rate_path(conn, :show, heart_rate))
        |> render("show.json", heart_rate: heart_rate)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SensorApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    heart_rate = Repo.get!(HeartRate, id)
    render(conn, "show.json", heart_rate: heart_rate)
  end

  def update(conn, heart_rate_params) do
    conn = fetch_query_params(conn)
    %{ "id" => id } = conn.params
    heart_rate = Repo.get!(HeartRate, id)
    changeset = HeartRate.changeset(heart_rate, heart_rate_params)

    case Repo.update(changeset) do
      {:ok, heart_rate} ->
        render(conn, "show.json", heart_rate: heart_rate)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SensorApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    heart_rate = Repo.get!(HeartRate, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(heart_rate)

    send_resp(conn, :no_content, "")
  end
end
