extends Card

@export var optional_sound: AudioStream

func apply_effects(_targets: Array[Node], char_stats: CharacterStats) -> void:
	char_stats.luck_locked = true
