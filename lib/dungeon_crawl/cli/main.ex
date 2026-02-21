defmodule DungeonCrawl.CLI.Main do
  alias DungeonCrawl.Character
  alias Mix.Shell.IO, as: Shell

  def start_game do
    welcome_message()
    Shell.prompt("Press Enter to continue")

    crawl(hero_choice(), DungeonCrawl.Room.all())
  end

  defp crawl(%{hit_points: 0}, _) do
    Shell.prompt("")
    Shell.cmd("clear")
    Shell.info("Unfortunately your wounds are too many to keep walking.")
    Shell.info("You fall onto the floor without strength to carry on.")
    Shell.info("Game over!")
    Shell.prompt("")
  end

  defp crawl(hero, rooms) do
    Shell.info("You keep moving forward to the next room.")
    Shell.prompt("Press Enter to continue")
    Shell.cmd("clear")
    Shell.info(Character.current_stats(hero))

    rooms
    |> Enum.random()
    |> DungeonCrawl.CLI.RoomActionsChoice.start()
    |> trigger_action(hero)
    |> handle_action_result
  end

  defp welcome_message do
    Shell.info("== Dungeon Crawl ===")
    Shell.info("You awake in a dungeon full of monsters.")
    Shell.info("You need to survive and find the exit.")
  end

  defp hero_choice do
    hero = DungeonCrawl.CLI.HeroChoice.start()
    %{hero | name: "You"}
  end

  defp trigger_action({room, action}, hero) do
    Shell.cmd("clear")
    room.trigger.run(hero, action)
  end

  defp handle_action_result({_, :exit}),
    do: Shell.info("You found the exit. You won the game. Congratulations!")

  defp handle_action_result({hero, _}), do: crawl(hero, DungeonCrawl.Room.all())
end
