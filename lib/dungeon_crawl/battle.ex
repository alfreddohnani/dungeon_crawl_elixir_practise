defmodule DungeonCrawl.Battle do
  alias DungeonCrawl.Character
  alias Mix.Shell.IO, as: Shell

  def fight(
        hero = %{hit_points: hero_hit_points},
        enemy = %{hit_points: enemy_hit_points}
      )
      when hero_hit_points == 0 or enemy_hit_points == 0, do: {hero, enemy}

  def fight(hero, enemy) do
    enemy_after_damage = attack(hero, enemy)
    hero_after_damage = attack(enemy_after_damage, hero)
    fight(hero_after_damage, enemy_after_damage)
  end

  defp attack(%{hit_points: hit_points_a}, character_b) when hit_points_a == 0, do: character_b

  defp attack(char_a, char_b) do
    char_a_damage = Enum.random(char_a.damage_range)
    char_b_after_damage = Character.take_damage(char_b, char_a_damage)

    char_a
    |> attack_message(char_a_damage)
    |> Shell.info()

    char_b_after_damage
    |> receive_message(char_a_damage)
    |> Shell.info()

    char_b_after_damage
  end

  defp attack_message(character = %{name: "You"}, damage) do
    "You attack with #{character.attack_description} " <>
      "and deal #{damage} damage."
  end

  defp attack_message(character, damage) do
    "#{character.name} attacks with " <>
      "#{character.attack_description} and " <>
      "deals #{damage} damage."
  end

  defp receive_message(character = %{name: "You"}, damage) do
    "You receive #{damage}. Current HP: #{character.hit_points}."
  end

  defp receive_message(character, damage) do
    "#{character.name} receives #{damage}. " <>
      "Current HP: #{character.hit_points}."
  end
end
