defmodule DungeonCrawl.Room.Triggers.Enemy do
  alias DungeonCrawl.Battle
  alias DungeonCrawl.Room.Trigger
  @behaviour Trigger

  alias Mix.Shell.IO, as: Shell

  @impl Trigger
  def run(hero, action) do
    enemy = Enum.random(DungeonCrawl.Enemies.all())

    Shell.info(enemy.description)
    Shell.info("The enemy #{enemy.name} wants to fight.")
    Shell.info("You were prepared and attack first.")
    {updated_hero, _enemy} = Battle.fight(hero, enemy)

    {updated_hero, action.id}
  end
end
