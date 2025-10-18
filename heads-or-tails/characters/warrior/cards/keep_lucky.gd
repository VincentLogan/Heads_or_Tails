extends Card

@export var optional_sound: AudioStream

func apply_effects(_targets: Array[Node], char_stats: CharacterStats) -> void:
	print("My awesome card has been played!")
	print("Targets: %s" % _targets)
