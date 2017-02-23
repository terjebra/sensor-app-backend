defmodule SensorApi.HeartRate do
  use SensorApi.Web, :model

  schema "heart_rates" do
    field :device_id, :string
    field :beat, :string
    field :date, Ecto.DateTime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:device_id, :beat, :date])
    |> validate_required([:device_id, :beat, :date])
  end
end
