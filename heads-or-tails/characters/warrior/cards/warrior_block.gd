extends Card

func apply_effects(targets: Array[Node], char_stats: CharacterStats) -> void:
	var block_effect := BlockEffect.new()
	var luck_effect := LuckEffect.new()
	
	block_effect.amount = 5
	block_effect.sound = sound
	block_effect.execute(targets)
