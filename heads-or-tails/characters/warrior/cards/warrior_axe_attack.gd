extends Card

func apply_effects(targets: Array[Node]) -> void:
	var damage_effect := DamageEffect.new()
	damage_effect.amount = 7
	damage_effect.sound = sound
	damage_effect.execute(targets)
	
