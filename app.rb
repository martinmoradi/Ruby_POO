# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def battle_2p
  player1 = Player.new('Josianne')
  player2 = Player.new('José')
  while player1.life_points.positive? && player2.life_points.positive?
    puts "Voici l'état de chaque joueur :"
    player1.show_state
    player2.show_state
    puts
    puts 'FIGHT !'
    player2.attacks(player1)
    break if player1.life_points <= 0

    player1.attacks(player2)
    break if player2.life_points <= 0
  end
end
