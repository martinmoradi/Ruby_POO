
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
  new_game.show_players

  while new_game.is_still_ongoing?
    new_game.combat_menu
    input = gets.chomp
    new_game.combat_input(input)
    new_game.combat_defense
  end
  new_game.end_game

end


full_game

