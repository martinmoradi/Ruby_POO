class Player
attr_accessor :name, :life_points

  def initialize(name_to_save)
    @name = name_to_save
    @life_points = 10
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie."
  end

  def get_damage(num)
    @life_points -= num 
    puts "Le joueur #{@name} a été tué !" if @life_points <= 0
  end

  def attacks(player, dmg = compute_damage)
    puts "#{@name} attaque #{player.name} !"
    puts "Et lui inflige #{dmg} points de dommages !"
    player.get_damage(dmg)
  end

   def compute_damage
    return rand(1..6)
  end

end

class HumanPlayer < Player
attr_accessor :weapon_level

  def initialize(name_to_save)
    super
    @weapon_level = 1
    @life_points = 100    
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}."
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon(dice = rand(1..6))
    puts "#{@name} a trouvé une arme de niveau #{dice}"
    if dice > @weapon_level
      puts "Youhou ! Cette arme est meilleure, #{@name} la conserve !"
      @weapon_level = dice
    else 
      puts "Pas de chance, elle est n'est pas mieux l'arme actuelle de #{@name} ..."
    end
  end

  def search_health_pack(dice = rand(1..6))
    if dice == 1 
      puts "#{@name} n'a rien trouvé..."
    elsif dice(2..5)
      puts "#{@name} a trouvé un pack de soin : 50 PV!"
      i = 50 
      while i > 0 || @life_points < 100
        i -= 1
        @life_points += 1
      end
    else puts "#{@name} a trouvé un pack de soin : 80 PV!"
      i = 80
      while i > 0 || @life_points < 100
        i -= 1
        @life_points += 1
      end
    end
    

  end
end