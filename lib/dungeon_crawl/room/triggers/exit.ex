defmodule DungeonCrawl.Room.Triggers.Exit do
  alias DungeonCrawl.Room.Trigger
  @behaviour Trigger

  @impl Trigger
  def run(character, _), do: {character, :exit}
end
