require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def human_battle
  welcome
  user1 = initialize_player
  enemies = initialize_enemies 

  # ----------------COMBAT---------------------#
  while user1.life_points > 0 && enemies.length > 0
    show_states(user1, *enemies)
    enemies = combat_turn(user1, *enemies)
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
  r3 = "=" * 120
  puts r3
  puts r1.center(width)
  puts r2.center(width)
  puts r3
end

def initialize_player
  puts "Rentre ton pseudo :"
  print "> "
  player_name = gets.chomp
  user1 = HumanPlayer.new(player_name) 
end 

def initialize_enemies 
  enemies = []
  bot1 = Player.new("Josianne")
  bot2 = Player.new("José")
  enemies << bot1 
  enemies << bot2
end 

def show_states(user1, *enemies)
  user1.show_state
  enemies.each { |bot| bot.show_state }
end

def combat_turn(user1, *enemies)
  user1.attacks(enemies.sample)
  enemies.reject! { |bot| bot.life_points <= 0 }
  enemies.compact
  enemies.each { |bot| bot.attacks(user1) }
end

def combat_menu(*enemies)
  puts "Quelle action veux-tu effecter ?"
  puts
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner"
  puts
  puts "attaquer un ennemi en vue :"
  enemies.each { |bot, i = 0| puts "#{i} - #{bot.show_state}" }
end


human_battle





