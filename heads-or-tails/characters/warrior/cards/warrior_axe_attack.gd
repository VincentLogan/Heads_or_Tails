extends Card

func apply_effects(targets: Array[Node], char_stats: CharacterStats) -> void:
	var damage_effect := DamageEffect.new()
	var luck_effect := LuckEffect.new()
	var luck_coins = char_stats.luck_coins
	luck_effect.amount = coin_gain
	if luck_coins > 1000:
		damage_effect.amount = 11
	elif luck_coins < 25 and can_effect():
		damage_effect.amount = 3
		GlobalSignals.card_effect_triggered.emit("so_unlucky")
	elif luck_coins >= 25 and luck_coins < 50 and can_effect():
		damage_effect.amount = 5
		GlobalSignals.card_effect_triggered.emit("unlucky")
	elif luck_coins >= 50 and luck_coins < 75 and can_effect():
		damage_effect.amount = 9
		GlobalSignals.card_effect_triggered.emit("lucky")
	elif luck_coins >= 75 and can_effect():
		damage_effect.amount = 11
		GlobalSignals.card_effect_triggered.emit("so_lucky")
	else:
		damage_effect.amount = 7

	
	damage_effect.sound = sound
	damage_effect.execute(targets)
