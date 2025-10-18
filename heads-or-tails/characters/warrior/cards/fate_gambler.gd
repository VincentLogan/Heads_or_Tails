extends Card

@export var optional_sound: AudioStream
var luck_effect := LuckEffect.new()
func apply_effects(targets: Array[Node], char_stats: CharacterStats) -> void:
	luck_effect.amount = coin_gain
	char_stats.luck_locked = true
	char_stats.luck_coins += 10000
	luck_effect.execute(targets)
