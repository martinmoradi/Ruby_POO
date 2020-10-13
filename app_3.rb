# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def full_game
  puts 'Rentre ton pseudo :'
  print '> '
  player_name = gets.chomp
  new_game = Game.new(player_name)
  new_game.welcome

  while new_game.is_still_ongoing?
    new_game.show_players
    new_game.new_players_in_sight
    new_game.combat_menu
    new_game.combat_input
    new_game.combat_defense
  end
  new_game.end_game
end

full_game
