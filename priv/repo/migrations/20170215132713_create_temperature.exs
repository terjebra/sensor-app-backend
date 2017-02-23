defmodule SensorApi.Repo.Migrations.CreateTemperature do
  use Ecto.Migration

  def change do
    create table(:temperatures) do
      add :reading, :string
      add :date, :datetime
      add :room_id, references(:rooms, on_delete: :nothing)

      timestamps()
    end
    create index(:temperatures, [:room_id])

  end
end
