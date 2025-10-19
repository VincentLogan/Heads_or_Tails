extends Card


func apply_effects(targets: Array[Node], char_stats: CharacterStats) -> void:
	var damage_effect := DamageEffect.new()
	var luck_effect := LuckEffect.new()
	var luck_coins = char_stats.luck_coins
	luck_effect.amount = coin_gain
	
	if char_stats.super_luck_mode:
		damage_effect.amount = 6
		GlobalSignals.card_effect_triggered.emit("so_lucky")
	elif not can_effect():
		damage_effect.amount = 4
		luck_effect.amount = -8
	else:
		if luck_coins < 25:
			damage_effect.amount = 2
			GlobalSignals.card_effect_triggered.emit("so_unlucky")
		elif luck_coins >= 25 and luck_coins < 50:
			damage_effect.amount = 3
			GlobalSignals.card_effect_triggered.emit("unlucky")
		elif luck_coins >= 50 and luck_coins < 75:
			damage_effect.amount = 5
			GlobalSignals.card_effect_triggered.emit("lucky")
		elif luck_coins >= 75:
			damage_effect.amount = 6
			GlobalSignals.card_effect_triggered.emit("so_lucky")

	
	damage_effect.sound = sound
	damage_effect.execute(targets)
	luck_effect.execute(targets)
