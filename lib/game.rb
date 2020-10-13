

class Game 
  attr_accessor :human_player, :enemies

  def initialize(name_to_save)
    @humanplayer = HumanPlayer.new(name_to_save)
    @enemies = []
    4.times { |player| @enemies << Player.new("player#{player}")}
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

  def kill_player(player)
    @enemies.delete(player)
  end

  def is_still_ongoing?
   @humanplayer.life_points.positive? && @enemies.length.positive?
  end

   def show_players
    puts "Le joueur #{@human_player.name} a #{@human_player.life_points} points de vie."
    puts "Il reste #{@enemies.size} ennemis. "    
  end

  def combat_menu
  puts 'Quelle action veux-tu effecter ?'
  puts
  puts 'a - chercher une meilleure arme'
  puts 's - chercher à se soigner'
  puts
  puts 'attaquer un ennemi en vue :'
  @enemies.each.with_index do |bot, idx|
    puts idx.to_s + "- #{bot.show_state}"
  end
  puts '-------------------------------'
  print '> '
end

def combat_input(input)
  input = gets.chomp
  if input.downcase == 'a'
    @humanplayer.search_weapon
  elsif input.downcase == 's'
    @humanplayer.search_health_pack
  elsif (0...enemies.length).include?(input.to_i)
    @humanplayer.attacks(@enemies[input.to_i])
  else puts 'Petit malin !'
       combat_menu
  end
  @enemies
end

  def combat_defense
    puts
    puts 'Les ennemies attaquent !'
    @enemies.each { |bot| bot.attacks(@humanplayer) }
  end

  def end_game
    if @humanplayer.life_points <= 0
    puts "#{@humanplayer.name} a perdu ! LOOOSER !"
    else
    puts "#{@humanplayer.name} a gagné ! Quel talent !"
    end 
  end




end