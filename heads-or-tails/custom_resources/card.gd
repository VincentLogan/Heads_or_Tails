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
@export_group("Card Effects")
@export var base_effect: Effect
@export var high_luck_effect: Effect
@export var low_luck_effect: Effect
@export var high_luck_threshold: int = 5
@export var low_luck_threshold: int = -3


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
	var player_stats = null
	for t in targets:
		if "stats" in t:
			player_stats = t.stats
			break

	if player_stats == null:
		print("⚠️ 未找到玩家 stats，无法应用效果")
		return

	var luck = player_stats.luck_coin
	print("🎲 当前幸运币:", luck)

	# 逐层判断幸运币阈值
	if luck >= high_luck_threshold and high_luck_effect:
		print("✨ 触发高运效果:", high_luck_effect)
		high_luck_effect.execute(targets)
	elif luck <= low_luck_threshold and low_luck_effect:
		print("💀 触发低运效果:", low_luck_effect)
		low_luck_effect.execute(targets)
	elif base_effect:
		print("⚙️ 触发普通效果:", base_effect)
		base_effect.execute(targets)
	else:
		print("❌ 没有效果被触发")


	




@export var description: String

# 🎲 幸运币机制
@export var luck_change: int = 0             # 打出后幸运币变化量
