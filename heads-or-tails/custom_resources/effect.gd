class_name Effect
extends Resource

@export var effect_type: String = "none"  # 例如："damage", "heal", "luck_gain"
@export var value: int = 0                # 效果数值
@export var sound: AudioStream

func execute(_targets: Array[Node]) -> void:
	for t in _targets:
		if not ("stats" in t):
			continue

		var stats = t.stats

		match effect_type:
			"damage":
				stats.hp -= value
				print("造成伤害：", value)

			"heal":
				stats.hp += value
				print("回复生命：", value)

			"luck_gain":
				stats.luck_coin += value
				print("改变幸运币：", value, " → 当前幸运币：", stats.luck_coin)

			_:
				print("未知效果类型：", effect_type)
