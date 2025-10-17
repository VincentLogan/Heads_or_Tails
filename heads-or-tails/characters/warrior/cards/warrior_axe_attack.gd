extends Card

func apply_effects(targets: Array[Node], char_stats: CharacterStats) -> void:
	var damage_effect := DamageEffect.new()
	var luck_effect := LuckEffect.new()

	luck_effect.amount = coin_gain
	luck_effect.execute(targets)
	if char_stats.luck_coins >= high_threshold:
		damage_effect.amount = 9
	elif char_stats.luck_coins <= low_threshold:
		damage_effect.amount = 5
	else:
		damage_effect.amount = 7
	damage_effect.sound = sound
	damage_effect.execute(targets)
