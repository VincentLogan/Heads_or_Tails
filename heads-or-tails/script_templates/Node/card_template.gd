# meta-name: Card Logic
# meta-description: What happens when a card is played.
extends Card
class_name CardTemplate

@export var name: String
@export var description: String
@export var cost: int = 1
@export var luck_event: LuckEvent = null

@export var optional_sound: AudioStream

func apply_effects(_targets: Array[Node]) -> void:
	print("My awesome card has been played!")
	print("Targets: %s" % _targets)
