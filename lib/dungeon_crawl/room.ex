defmodule DungeonCrawl.Room do
  alias DungeonCrawl.Room.Triggers
  alias DungeonCrawl.Room

  import DungeonCrawl.Room.Action

  defstruct description: nil, actions: [], trigger: nil

  def all,
    do: [
      %Room{
        description: "You found a quite place. Looks safe for a litte nap.",
        actions: [forward(), rest()],
        trigger: Triggers.Rest
      },
      %Room{
        description: "You can see the light of day. You found the exit!",
        actions: [forward()],
        trigger: Triggers.Exit
      },
      %Room{
        description: "You can see an enemy blocking your path.",
        actions: [forward()],
        trigger: Triggers.Enemy
      }
    ]
end
