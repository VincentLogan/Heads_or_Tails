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
@export var luck_gain := 0 #使用牌后幸运币的变化量
@export var high_luck_threshold := 5#高幸运阈值
@export var low_luck_threshold := -5#低幸运阈值
#三种效果
@export var base_effect: Resource
@export var high_luck_effect: Resource
@export var low_luck_effect: Resource

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
		apply_effects(targets)
	else:
		apply_effects(_get_targets(targets))
		
func apply_effects(targets: Array[Node]) -> void:
	if targets.size() == 0:
		return
	
	var player = targets[0]
	if not player or not ("stats" in player):
		push_warning(("Card missing valid player target"))
		return
	
	var stats = player.stats
	
	#修改幸运币
	stats.luck_coin += luck_gain
	print(id, "修改幸运币 -> ", stats.luck_coin)
	
	#检查阈值
	if stats.luck_coin >= high_luck_threshold and high_luck_effect:
		print("强运")
		high_luck_effect.execute(targets)
	elif stats.luck_coin <= low_luck_threshold and low_luck_effect:
		print("低运")
		low_luck_effect.execute(target)
	elif base_effect:
		print("无效果")
		base_effect.execute(targets)
