extends Card


func apply_effects(_targets: Array[Node], char_stats: CharacterStats) -> void:
	var damage_effect := DamageEffect.new()
	damage_effect.amount = 4
	damage_effect.sound = sound
	damage_effect.execute(_targets)
