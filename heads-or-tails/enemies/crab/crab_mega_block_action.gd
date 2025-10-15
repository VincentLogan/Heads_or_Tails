extends EnemyAction

@export var block := 15
@export var hp_threshold := 6#hp阈值，低于这个hp会触发超级格挡

var already_used := false#是否用过

func is_performable() -> bool:
	if not enemy or already_used:
		return false
	
	var is_low := enemy.stats.health <= hp_threshold#is_low是一个检查是否到达阈值的bool值
	already_used = is_low
	
	return is_low

func perform_action() -> void:
	if not enemy or not target:
		return
	
	var block_effect := BlockEffect.new()
	block_effect.amount = block
	block_effect.sound = sound
	block_effect.execute([enemy])
	
	get_tree().create_timer(0.6, false).timeout.connect(
		func():
			Events.enemy_action_completed.emit(enemy)
	)
