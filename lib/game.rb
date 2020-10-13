# frozen_string_literal: true

class Game
  attr_accessor :humanplayer, :enemies_in_sight, :players_left

  def initialize(player_name)
    @humanplayer = HumanPlayer.new(player_name)
    @enemies_in_sight = []
    @players_left = 10
  end

  def new_players_in_sight
    puts
    unless @enemies_in_sight.length >= players_left
      dice = rand(1..6)
      if dice == 1
        puts 'Aucun nouvel adversaire en vue !'
      elsif (2..4).include?(dice)
        puts 'Un nouvel adversaire en vue !'
        @enemies_in_sight << Player.new("bot#{rand(9999).to_s.center(4, rand(9).to_s)}")
      else
        puts 'Deux nouveaux adversaire en vue !!'
        2.times { @enemies_in_sight << Player.new("bot#{rand(9999).to_s.center(4, rand(9).to_s)}") }
      end
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

  def is_still_ongoing?
    @humanplayer.life_points.positive? && @players_left.positive?
  end

  def show_players
    puts "Le joueur #{@humanplayer.name} a #{@humanplayer.life_points} points de vie."
    puts "Il reste #{@players_left} ennemis. "
  end

  def combat_menu
    puts
    puts '-------------------------------'
    puts 'Quelle action veux-tu effecter ?'
    puts
    puts 'a - chercher une meilleure arme'
    puts 's - chercher à se soigner'
    puts
    puts 'attaquer un ennemi en vue :'
    @enemies_in_sight.each.with_index do |bot, idx|
      puts idx.to_s + "- #{bot.show_state}"
    end
    puts '-------------------------------'
    print '> '
  end

  def combat_input
    input = gets.chomp
    puts
    if input.downcase == 'a'
      @humanplayer.search_weapon
    elsif input.downcase == 's'
      @humanplayer.search_health_pack
    elsif (0...enemies_in_sight.length).include?(input.to_i)
      @humanplayer.attacks(@enemies_in_sight[input.to_i])
      kill_player if @enemies_in_sight[input.to_i].life_points <= 0

    else puts 'Petit malin !'
         combat_menu
    end
  end

  def kill_player
    #---------Supprimer les bots morts de l'array ----#
    @enemies_in_sight.reject! { |bot| bot.life_points <= 0 }
    @enemies_in_sight.compact
    @players_left -= 1
  end

  def combat_defense
    puts
    puts 'Les ennemies attaquent !'
    @enemies_in_sight.each do |bot|
      bot.attacks(@humanplayer)
      break if @humanplayer.life_points <= 0
    end
    puts puts '-------------------------------'
    @humanplayer.show_state
    puts
    puts
    puts '~~~~~~~~~~~~FIN DU TOUR~~~~~~~~~~~~~~'
  end

  def end_game
    if @humanplayer.life_points <= 0
      puts "#{@humanplayer.name} a perdu ! LOOOSER !"
    else
      puts "#{@humanplayer.name} a gagné ! Quel talent !"
    end
  end
end
