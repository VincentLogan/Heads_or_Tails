extends Effect
class_name LuckEffect

var amount:int = 0

func execute(targets: Array[Node]) -> void:
	for target in targets:
		if not target:
			continue
		if target is Player:
			target.add_luck(amount)
