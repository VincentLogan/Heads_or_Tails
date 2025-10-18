class_name Card
extends Resource

enum Type{ATTACK, DEFEND, POWER}
enum Target{SELF, SINGLE_ENENMY, ALL_ENEMIES, EVERYONE}

@export_group("Card Attributes")
@export var id: String
@export var type: Type
@export var target: Target
@export var cost: int
@export_group("Card Visuals")
@export var icon: Texture
@export_multiline var tooltip_text: String
@export var sound: AudioStream

@export var coin_gain: int = 0 #幸运币增加
@export var high_threshold = 4 #高阈值
@export var low_threshold = -3 #低阈值

@export var normal_effects: Array = []
@export var high_luck_effects: Array = []
@export var low_luck_effects: Array = []

func is_single_targeted() -> bool:
	return target == Target.SINGLE_ENENMY

func _get_targets(targets: Array[Node]) -> Array[Node]:
	if not targets:
		return []
		
	var tree := targets[0].get_tree()

	match target:
		Target.SELF:
			return tree.get_nodes_in_group("player")
		Target.ALL_ENEMIES:
			return tree.get_nodes_in_group("enemies")
		Target.EVERYONE:
			return tree.get_nodes_in_group("player") + tree.get_nodes_in_group("enemies")
		_:
			return []
			
func play(targets: Array[Node], char_stats: CharacterStats) -> void:
	Events.card_played.emit(self)
	char_stats.mana -= cost
	
	if is_single_targeted():
		apply_effects(targets, char_stats)
	else:
		apply_effects(_get_targets(targets), char_stats)
	
	#使用后改变幸运币
	if coin_gain != 0:
		if "add_luck" in char_stats:
			char_stats.add_luck(coin_gain)
		else:
			char_stats.luck += coin_gain
	
func apply_effects(_targets: Array[Node],_char_stats: CharacterStats) -> void:
	pass
	
func can_effect(p: float) -> bool:
	var n = randf()
	if n <= p:
		return true
	else:
		return false
