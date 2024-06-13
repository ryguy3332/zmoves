Z_MOVES = {
  "622" => {  # Replace with move ID
    move: "Breakneck Blitz", # Z-Move name
    user_item: "Normallium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power) # Replace with actual base move power
	# Custom effects function
 effect: lambda do |user, target|
      # Ignores Pixilate, Refrigerate, Aerilate, and Galvanize abilities
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
	ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Breakneck Blitz!"
          next
        end
      end
 ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end
	  
      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Breakneck Blitz!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
	  
	   # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Breakneck Blitz!"
    end, 
	    :is_contact_move => false,  # Mark as non-contact move
  },
  
   "623" => {  # Replace with move ID
    move: "Breakneck Blitz", # Z-Move name
    user_item: "Normallium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
	# Custom effects function
 effect: lambda do |user, target|
      # Ignores Pixilate, Refrigerate, Aerilate, and Galvanize abilities
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
	   ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Breakneck Blitz!"
          next
        end
      end
 ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end
	  
      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Breakneck Blitz!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
	  
	   # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Breakneck Blitz!"
    end, 
	    :is_contact_move => false,  # Mark as non-contact move
  },
    "624" => {  # Replace with move ID
    move: "All-Out Pummling", # Z-Move name
    user_item: "Fightinium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Breakneck Blitz!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s All-Out Pummling!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used All-Out Pummling!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
   "625" => {  # Replace with move ID
    move: "All-Out Pummling", # Z-Move name
    user_item: "Fightinium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on All-Out Pummling!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s All-Out Pummling!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used All-Out Pummling!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
   "626" => {  # Replace with move ID
    move: "Supersonic Skystrike", # Z-Move name
    user_item: "Flyinium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Supersonic Skystrike!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Supersonic Skystrike!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Supersonic Skystrike!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
   "627" => {  # Replace with move ID
    move: "Supersonic Skystrike", # Z-Move name
    user_item: "Flyinium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Supersonic Skystrike!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Supersonic Skystrike!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Supersonic Skystrike!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
   "628" => {  # Replace with move ID
    move: "Acid Downpour", # Z-Move name
    user_item: "Poisinium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Acid Downpour!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Acid Downpour!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
	  
	  # Calculate speed bonus
      speed_bonus = (user.stats[:spd] - target.stats[:spd]) / 100.0  # Adjust divisor as needed
      damage_modifier = 1.0 + [speed_bonus, 0.5].max  # Cap bonus at 0.5
      damage = rand(user.stats[:sp_atk]) + self.base_power * damage_modifier
      
      
      target.reduce_hp(damage)
      puts "#{user.name} used Acid Downpour!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  "629" => {  # Replace with move ID
    move: "Acid Downpour", # Z-Move name
    user_item: "Poisinium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Acid Downpour!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Acid Downpour!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
	  
	  # Calculate speed bonus
      speed_bonus = (user.stats[:spd] - target.stats[:spd]) / 100.0  # Adjust divisor as needed
      damage_modifier = 1.0 + [speed_bonus, 0.5].max  # Cap bonus at 0.5
      damage = rand(user.stats[:sp_atk]) + self.base_power * damage_modifier
      
      
      target.reduce_hp(damage)
      puts "#{user.name} used Acid Downpour!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  
  "630" => {  # Replace with move ID
    move: "Tectonic Rage", # Z-Move name
    user_item: "Groundium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Tectonic Rage!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Tectonic Rage!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Tectonic Rage!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  
  
  "631" => {  # Replace with move ID
    move: "Tectonic Rage", # Z-Move name
    user_item: "Groundium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Tectonic Rage!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Tectonic Rage!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Tectonic Rage!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  
  "632" => {  # Replace with move ID
    move: "Continental Crush", # Z-Move name
    user_item: "Rockium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Continental Crush!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Continental Crush!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Continental Crush!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  
   "633" => {  # Replace with move ID
    move: "Continental Crush", # Z-Move name
    user_item: "Rockium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Continental Crush!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Continental Crush!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Continental Crush!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  "634" => {  # Replace with move ID
    move: "Savage Spin-Out", # Z-Move name
    user_item: "Bugiunmium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Savage Spin-Out!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Savage Spin-Out!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Savage Spin-Out!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
    "635" => {  # Replace with move ID
    move: "Savage Spin-Out", # Z-Move name
    user_item: "Bugiunmium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Savage Spin-Out!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Savage Spin-Out!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Savage Spin-Out!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  "636" => {  # Replace with move ID
    move: "Never-Ending Nightmare", # Z-Move name
    user_item: "Ghostium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Never-Ending Nightmare!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Never-Ending Nightmare!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Never-Ending Nightmare!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  "637" => {  # Replace with move ID
    move: "Never-Ending Nightmare", # Z-Move name
    user_item: "Ghostium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Never-Ending Nightmare!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Never-Ending Nightmare!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Never-Ending Nightmare!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  
  "638" => {  # Replace with move ID
    move: "Corkscrew Crash", # Z-Move name
    user_item: "Steelium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Corkscrew Crash!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Corkscrew Crash!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Corkscrew Crash!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
   "639" => {  # Replace with move ID
    move: "Corkscrew Crash", # Z-Move name
    user_item: "Steelium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Corkscrew Crash!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Corkscrew Crash!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Corkscrew Crash!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
   "640" => {  # Replace with move ID
    move: "Inferno Overdrive", # Z-Move name
    user_item: "Firium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Inferno Overdrive!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Inferno Overdrive!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Inferno Overdrive!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
   "641" => {  # Replace with move ID
    move: "Inferno Overdrive", # Z-Move name
    user_item: "Firium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Inferno Overdrive!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Inferno Overdrive!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Inferno Overdrive!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  
   "642" => {  # Replace with move ID
    move: "Hydro Vortex", # Z-Move name
    user_item: "Waterium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Hydro Vortex!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Hydro Vortex!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Hydro Vortex!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  "643" => {  # Replace with move ID
    move: "Hydro Vortex", # Z-Move name
    user_item: "Waterium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Hydro Vortex!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Hydro Vortex!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Hydro Vortex!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  "644" => {  # Replace with move ID
    move: "Bloom Doom", # Z-Move name
    user_item: "Grassium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Bloom Doom!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Bloom Doom!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Bloom Doom!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  
    "645" => {  # Replace with move ID
    move: "Bloom Doom", # Z-Move name
    user_item: "Grassium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Bloom Doom!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Bloom Doom!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Bloom Doom!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
    "646" => {  # Replace with move ID
    move: "Gigavolt Havoc", # Z-Move name
    user_item: "Electrium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Gigavolt Havoc!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Gigavolt Havoc!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Gigavolt Havoc!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
   "647" => {  # Replace with move ID
    move: "Gigavolt Havoc", # Z-Move name
    user_item: "Electrium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Gigavolt Havoc!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Gigavolt Havoc!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Gigavolt Havoc!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
   "648" => {  # Replace with move ID
    move: "Shattered Psyche", # Z-Move name
    user_item: "Psychium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Shattered Psyche!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Shattered Psyche!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Shattered Psyche!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  
  "649" => {  # Replace with move ID
    move: "Shattered Psyche", # Z-Move name
    user_item: "Psychium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Shattered Psyche!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Shattered Psyche!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Shattered Psyche!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  
    "650" => {  # Replace with move ID
    move: "Subzero Slammer", # Z-Move name
    user_item: "Icium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Subzero Slammer!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Subzero Slammer!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Subzero Slammer!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  "651" => {  # Replace with move ID
    move: "Subzero Slammer", # Z-Move name
    user_item: "Icium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Subzero Slammer!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Subzero Slammer!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Subzero Slammer!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  
   "652" => {  # Replace with move ID
    move: "Devastating Drake", # Z-Move name
    user_item: "Dragonium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Devastating Drake!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Devastating Drake!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Devastating Drake!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
   "653" => {  # Replace with move ID
    move: "Devastating Drake", # Z-Move name
    user_item: "Dragonium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Devastating Drake!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Devastating Drake!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Devastating Drake!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  
    "654" => {  # Replace with move ID
    move: "Black Hole Eclipse", # Z-Move name
    user_item: "Darkinium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Black Hole Eclipse!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Black Hole Eclipse!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Black Hole Eclipse!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  
   "655" => {  # Replace with move ID
    move: "Black Hole Eclipse", # Z-Move name
    user_item: "Darkinium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Black Hole Eclipse!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Black Hole Eclipse!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Black Hole Eclipse!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  
   "656" => {  # Replace with move ID
    move: "Twinkle Tackle", # Z-Move name
    user_item: "Fairium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Twinkle Tackle!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Twinkle Tackle!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Twinkle Tackle!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  
   "657" => {  # Replace with move ID
    move: "Twinkle Tackle", # Z-Move name
    user_item: "Fairium Z-Ring", # Item required for Z-Move
    base_power: calculate_z_move_power(base_power), # Replace with actual base move power
   # Custom effects function
    effect: lambda do |user, target|
      # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Twinkle Tackle!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Twinkle Tackle!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Twinkle Tackle!"
    end,
    :is_contact_move => false,  # Mark as non-contact move
  }, 
  
  
  "658" => {  # Replace with move ID (if necessary)
  move: "Catastropika",  # Z-Move name
  user_item: "Pikanium Z-Ring",  # Item required for Z-Move
  base_power: 210,  # Fixed damage for Z-Move
  # Custom effects function
  effect: lambda do |user, target|
    # Check if the user used Volt Tackle before attempting the Z-Move
    if !user.last_move || user.last_move.id != 334  # Replace with actual Volt Tackle ID (might be different)
      puts "#{user.name} needs to use Volt Tackle first!"
      return false  # Exit the Z-Move if the condition isn't met
    end


    # Catastropika is now a physical attack
    damage = rand(user.stats[:atk]) + self.base_power

   # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Catastropika!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Catastropika!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Catastropika!"
    end,
	
  :is_contact_move => true,  # Mark as contact move
},
  
  "659" => {  # Replace with move ID (if necessary)
  move: "	Stoked Sparksurfer",  # Z-Move name
  user_item: "Aloraichium Z-Ring",  # Item required for Z-Move
  base_power: 175,  # Fixed damage for Z-Move
  # Custom effects function
  effect: lambda do |user, target|
    # Check if the user used Thunderbolt before attempting the Z-Move
    if !user.last_move || user.last_move.id != 085  # Replace with actual Volt Tackle ID (might be different)
      puts "#{user.name} needs to use Volt Tackle first!"
      return false  # Exit the Z-Move if the condition isn't met
    end


    # Stoked Sparksurfer is now a physical attack
    damage = rand(user.stats[:sp_atk]) + self.base_power

   # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Stoked Sparksurfer!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Stoked Sparksurfer!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Stoked Sparksurfer!"
    end,
	
  :is_contact_move => false,  # Mark as contact move
},

"660" => {  # Replace with move ID (if necessary)
  move: "Extreme Evoboost",  # Z-Move name
  user_item: "Eeveeium Z-Ring",  # Required Z-Crystal
  base_power: 0,  # No damage (stat buffing Z-Move)
  # Custom effects function
  effect: lambda do |user|
    # Check if the user used Volt Tackle before attempting the Z-Move
    if !user.last_move || user.last_move.id != 387  # Replace with actual Volt Tackle ID (might be different)
      puts "#{user.name} needs to use Volt Tackle first!"
      return false  # Exit the Z-Move if the condition isn't met
    end

    # Increase all stats by 2 stages
    [:atk, :sp_atk, :defense, :sp_def].each do |stat|
      user.stats[stat] = [user.stats[stat] * 2, user.base_stats[stat] + Battle:: STATS_ALIMITS].min
    end
    puts "#{user.name} used Extreme Evoboost!"
  end,
  :is_contact_move => false,  # Mark as non-contact move
},
  
    "661" => {  # Replace with move ID (if necessary)
  move: "Pulverizing Pancake",  # Z-Move name
  user_item: "Snorlium Z-Ring",  # Item required for Z-Move
  base_power: 210,  # Fixed damage for Z-Move
  # Custom effects function
  effect: lambda do |user, target|
    # Check if the user used Volt Tackle before attempting the Z-Move
    if !user.last_move || user.last_move.id != 416  # Replace with actual Volt Tackle ID (might be different)
      puts "#{user.name} needs to use Giga Impact first!"
      return false  # Exit the Z-Move if the condition isn't met
    end


    # Pulverizing Pancake is now a physical attack
    damage = rand(user.stats[:atk]) + self.base_power

   # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Pulverizing Pancake!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Pulverizing Pancake!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Pulverizing Pancake!"
    end,
	
  :is_contact_move => true,  # Mark as contact move
},


  "662" => {  # Replace with move ID (if necessary)
  move: "Genesis Supernova",  # Z-Move name
  user_item: "Mewnium Z-Ring",  # Item required for Z-Move
  base_power: 185,  # Fixed damage for Z-Move
  # Custom effects function
  effect: lambda do |user, target|
    # Check if the user used Volt Tackle before attempting the Z-Move
    if !user.last_move || user.last_move.id != 094  # Replace with actual Volt Tackle ID (might be different)
      puts "#{user.name} needs to use Psychic first!"
      return false  # Exit the Z-Move if the condition isn't met
    end


    # Pulverizing Pancake is now a physical attack
    damage = rand(user.stats[:sp_atk]) + self.base_power

   # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on Genesis Supernova!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s Genesis Supernova!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used Genesis Supernova!"
    end,
	
  :is_contact_move => false,  # Mark as contact move
},
  
  
   "663" => {  # Replace with move ID (if necessary)
  move: "	Sinister Arrow Raid",  # Z-Move name
  user_item: "Mewnium Z-Ring",  # Item required for Z-Move
  base_power: 180,  # Fixed damage for Z-Move
  # Custom effects function
  effect: lambda do |user, target|
    # Check if the user used Spirit Shackle before attempting the Z-Move
    if !user.last_move || user.last_move.id != 662  # Replace with actual Spirit Shackle ID (might be different)
      puts "#{user.name} needs to use Spirit Shackle first!"
      return false  # Exit the Z-Move if the condition isn't met
    end


    # Pulverizing Pancake is now a physical attack
    damage = rand(user.stats[:atk]) + self.base_power

   # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on 	Sinister Arrow Raid!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s 	Sinister Arrow Raid!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used 	Sinister Arrow Raid!"
    end,
	
  :is_contact_move => true,  # Mark as contact move
},


 "664" => {  # Replace with move ID (if necessary)
  move: "Malicious Moonsault",  # Z-Move name
  user_item: "Incinium Z-Ring",  # Item required for Z-Move
  base_power: 180,  # Fixed damage for Z-Move
  # Custom effects function
  effect: lambda do |user, target|
    # Check if the user used Spirit Shackle before attempting the Z-Move
    if !user.last_move || user.last_move.id != 663  # Replace with actual 	Malicious Moonsault ID (might be different)
      puts "#{user.name} needs to use 	Malicious Moonsault!"
      return false  # Exit the Z-Move if the condition isn't met
    end


    # Pulverizing Pancake is now a physical attack
    damage = rand(user.stats[:atk]) + self.base_power

   # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on 	Malicious Moonsault!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s 		Malicious Moonsault!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used 		Malicious Moonsault!"
    end,
	
  :is_contact_move => true,  # Mark as contact move
},

 "665" => {  # Replace with move ID (if necessary)
  move: "	Oceanic Operetta",  # Z-Move name
  user_item: "Primarium Z-Ring",  # Item required for Z-Move
  base_power: 195,  # Fixed damage for Z-Move
  # Custom effects function
  effect: lambda do |user, target|
    # Check if the user used 	Oceanic Operetta before attempting the Z-Move
    if !user.last_move || user.last_move.id != 664  # Replace with actual 	Oceanic Operetta ID (might be different)
      puts "#{user.name} needs to use Oceanic Operetta!"
      return false  # Exit the Z-Move if the condition isn't met
    end


    # Pulverizing Pancake is now a physical attack
    damage = rand(user.stats[:sp_atk]) + self.base_power

   # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on 	Oceanic Operetta!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:sp_atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s 	Oceanic Operetta!"
      else
        damage = rand(user.stats[:sp_atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used 	Oceanic Operetta!"
    end,
	
  :is_contact_move => false,  # Mark as contact move
},

 "666" => {  # Replace with move ID (if necessary)
  move: "	Splintered Stormshards",  # Z-Move name
  user_item: "Lycanium Z-Ring",  # Item required for Z-Move
  base_power: 	190,  # Fixed damage for Z-Move
  # Custom effects function
  effect: lambda do |user, target|
    # Check if the user used Spirit Shackle before attempting the Z-Move
    if !user.last_move || user.last_move.id != 444  # Replace with actual 	Malicious Moonsault ID (might be different)
      puts "#{user.name} needs to use 	Malicious Moonsault!"
      return false  # Exit the Z-Move if the condition isn't met
    end


    # Pulverizing Pancake is now a physical attack
    damage = rand(user.stats[:atk]) + self.base_power

   # Ignores abilities and moves
      ignores_abilities = [:Pixilate, :Refrigerate, :Aerilate, :Galvanize]
      ignores_moves = [:Magic Coat, :Snatch, :Mirror Move]
      ignores_abilities.each do |ability|
        if target.ability == ability
          puts "#{target.name}'s ability, #{ability}, has no effect on 	Malicious Moonsault!"
          next
        end
      end
      ignores_moves.each do |move|
        if battle.used_move_this_turn?(move)
          puts "#{target.name} is unaffected by #{move}!"
          next
        end
      end

      # Half damage through Protect
      if target.effects.include?(:Protect)
        damage = rand(user.stats[:atk]) + self.base_power / 2
        puts "It protected itself from #{user.name}'s 		Malicious Moonsault!"
      else
        damage = rand(user.stats[:atk]) + self.base_power
      end
      
      # Apply King's Rock flinch chance
      if user.item == :KingsRock && rand < Battle::KING_ROCK_FLINCH_CHANCE
        target.effects.push(:Flinch)
        puts "#{target.name} flinched due to King's Rock!"
      end
      
      target.reduce_hp(damage)
      puts "#{user.name} used 		Malicious Moonsault!"
    end,
	
  :is_contact_move => true,  # Mark as contact move
}



end