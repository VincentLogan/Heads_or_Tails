extends Card

func apply_effects(_targets: Array[Node], char_stats: CharacterStats) -> void:
	var block_effect := BlockEffect.new()
	char_stats.luck_locked = true
	block_effect.sound = sound
	block_effect.execute(_targets)
