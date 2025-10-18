extends Card

@export var optional_sound: AudioStream

func apply_effects(targets: Array[Node], char_stats: CharacterStats) -> void:
	var luck_effect := LuckEffect.new()

	luck_effect.amount = coin_gain
