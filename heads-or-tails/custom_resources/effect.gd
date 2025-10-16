class_name Effect
extends Resource

@export var effect_type: String = ""
@export var value: int = 0 #效果数值
@export var sound: AudioStream

func execute(targets: Array[Node]) -> void:
	for t in targets:
		if not ("stats" in t):
			continue
			
		var stats = t.stats
		
		match effect_type:
			"damage":
				stats.hp -= value
			"heal":
				stats.hp += value
			"luck_gain":
				stats.luck_coin += value
			_:
				print("未知")
