defmodule SensorApi.Repo.Migrations.CreateHeartRate do
  use Ecto.Migration

  def change do
    create table(:heart_rates) do
      add :device_id, :string
      add :beat, :string
      add :date, :datetime

      timestamps()
    end

  end
end
