extends Card

func apply_effects(targets: Array[Node], char_stats: CharacterStats) -> void:
	var block_effect := BlockEffect.new()
	var luck_effect := LuckEffect.new()
	
	var luck_coins = char_stats.luck_coins
	luck_effect.amount = coin_gain

	if char_stats.super_luck_mode:
		block_effect.amount = 11
		GlobalSignals.card_effect_triggered.emit("so_lucky")
	elif not can_effect():
		block_effect.amount = 7
	else:
		if luck_coins < 25:
			block_effect.amount = 3
			GlobalSignals.card_effect_triggered.emit("so_unlucky")
		elif luck_coins >= 25 and luck_coins < 50:
			block_effect.amount = 5
			GlobalSignals.card_effect_triggered.emit("unlucky")
		elif luck_coins >= 50 and luck_coins < 75:
			block_effect.amount = 9
			GlobalSignals.card_effect_triggered.emit("lucky")
		elif luck_coins >= 75:
			block_effect.amount = 11
			GlobalSignals.card_effect_triggered.emit("so_lucky")


	block_effect.sound = sound
	block_effect.execute(targets)
