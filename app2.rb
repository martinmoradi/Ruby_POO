# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def human_battle
  welcome
  user1 = initialize_player
  enemies = initialize_enemies

  # ----------------COMBAT---------------------#
  while is_still_ongoing?(user1, *enemies)
    enemies = combat_attack(user1, *enemies)
    user1 = combat_defense(user1, *enemies)
    puts
  end

  # ---------------FIN DU GAME-----------------#
  if user1.life_points <= 0
    puts "#{user1.name} a perdu ! LOOOSER !"
  else
    puts "#{user1.name} a gagné ! Quel talent !"
  end
end

def welcome
  width = 120
  r1 = "Bienvenue sur 'ILS VEULENT TOUS MA POO' !"
  r2 = "Le but du jeu est d'être le dernier survivant !"
  r3 = '=' * 120
  puts r3
  puts r1.center(width)
  puts r2.center(width)
  puts r3
end

def initialize_player
  puts 'Rentre ton pseudo :'
  print '> '
  player_name = gets.chomp
  user1 = HumanPlayer.new(player_name)
end

def initialize_enemies
  enemies = []
  bot1 = Player.new('Josianne')
  bot2 = Player.new('José')
  enemies << bot1
  enemies << bot2
end

def show_states(user1, *enemies)
  user1.show_state
  enemies.each(&:show_state)
end

def combat_attack(user1, *enemies)
  puts '-------------------------------'
  user1.show_state
  combat_menu(*enemies)
  enemies = combat_input(user1, *enemies)
  #---------Supprimer les bots morts de l'array ----#
  enemies.reject! { |bot| bot.life_points <= 0 }
  enemies.compact
end

def combat_defense(user1, *enemies)
  puts
  puts 'Les ennemies attaquent !'
  enemies.each { |bot| bot.attacks(user1) }
  user1
end

def combat_menu(*enemies)
  puts 'Quelle action veux-tu effecter ?'
  puts
  puts 'a - chercher une meilleure arme'
  puts 's - chercher à se soigner'
  puts
  puts 'attaquer un ennemi en vue :'
  enemies.each.with_index do |bot, idx|
    puts idx.to_s + "- #{bot.show_state}"
  end
  puts '-------------------------------'
  print '> '
end

def combat_input(user1, *enemies)
  input = gets.chomp
  if input.downcase == 'a'
    user1.search_weapon
  elsif input.downcase == 's'
    user1.search_health_pack
  elsif (0...enemies.length).include?(input.to_i)
    user1.attacks(enemies[input.to_i])
  else puts 'Petit malin'
       combat_menu(*enemies)
  end
  enemies
end

def is_still_ongoing?(user1, *enemies)
  false
  true if user1.life_points.positive? && enemies.length.positive?
end

human_battle
