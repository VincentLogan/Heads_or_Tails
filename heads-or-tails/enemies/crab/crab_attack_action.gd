extends EnemyAction

@export var damage := 5

func perform_action() -> void:
	if not enemy or not target:
		return
	
	var tween := create_tween().set_trans(Tween.TRANS_QUINT)#缓动动画
	var start := enemy.global_position#敌人一开始的位置
	var end := target.global_position + Vector2.RIGHT * 32#敌人在玩家右方的位置
	var damage_effect := DamageEffect.new()#创建一个新的伤害效果
	var target_array: Array[Node] = [target]
	damage_effect.amount = damage
	damage_effect.sound = sound
	
	tween.tween_property(enemy, "global_position", end, 0.4)
	tween.tween_callback(damage_effect.execute.bind(target_array))
	tween.tween_interval(0.25)
	tween.tween_property(enemy, "global_position", start, 0.4)
	
	tween.finished.connect(
		func():
			Events.enemy_action_completed.emit(enemy)
	)
