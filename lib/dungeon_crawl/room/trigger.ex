defmodule DungeonCrawl.Room.Trigger do
  alias DungeonCrawl.Room.Action
  alias DungeonCrawl.Character

  @callback run(Character.t(), Action.t()) :: {Character.t(), atom}
end
