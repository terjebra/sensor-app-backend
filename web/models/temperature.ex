defmodule SensorApi.Temperature do
  use SensorApi.Web, :model

  schema "temperatures" do
    field :reading, :string
    field :date, Timex.Ecto.DateTime
    belongs_to :room, SensorApi.Room

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:reading, :date])
    |> validate_required([:reading, :date])
  end
end
