extends Card

func apply_effects(targets: Array[Node], char_stats: CharacterStats) -> void:
	var damage_effect := DamageEffect.new()
	var luck_effect := LuckEffect.new()
	var luck_coins = char_stats.luck_coins
	var luck = char_stats.get_luck()
	
	luck_effect.amount = coin_gain
	luck_effect.execute(targets)
	if not can_effect(0.2):
		damage_effect.amount = 7
	else:
		if luck_coins < 25:
			damage_effect.amount = 3
		elif luck_coins >= 25 and luck_coins < 50:
			damage_effect.amount = 5
		elif luck_coins >= 50 and luck_coins < 75:
			damage_effect.amount = 9
		elif luck_coins >= 75 and luck_coins < 100:
			damage_effect.amount = 11
					
	damage_effect.sound = sound
	damage_effect.execute(targets)
