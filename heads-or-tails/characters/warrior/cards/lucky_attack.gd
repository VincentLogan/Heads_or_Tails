extends Card

@export var optional_sound: AudioStream

func apply_effects(targets: Array[Node], char_stats: CharacterStats) -> void:
	var damage_effect := DamageEffect.new()
	var luck_effect := LuckEffect.new()
	var luck_coins = char_stats.luck_coins
	luck_effect.amount = coin_gain
	if luck_coins <= 50:
		damage_effect.amount = 7
		if luck_coins < 20:
			char_stats.luck_coins = 0
		else:
			char_stats.luck_coins -= 20
	else:
		var damage_effect_amount = luck_coins - 50
		damage_effect.amount = 7 + damage_effect_amount / 2
		char_stats.luck_coins -= 20
		GlobalSignals.card_effect_triggered.emit("so_lucky")
		
	damage_effect.sound = sound
	damage_effect.execute(targets)
