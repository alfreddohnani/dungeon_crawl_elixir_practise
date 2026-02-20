defmodule DungeonCrawl.Room.Triggers.Rest do
  alias DungeonCrawl.Room.Trigger

  @behaviour Trigger

  @impl Trigger
  def run(character, _), do: {character, :rest}
end
