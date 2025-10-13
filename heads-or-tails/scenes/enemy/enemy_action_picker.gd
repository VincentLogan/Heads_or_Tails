class_name EnemyActionPicker
extends Node

@export var enemy: Enemy: set = _set_enemy
@export var target: Node2D: set = _set_target

@onready var total_weight := 0.0

func _ready() -> void:
	target = get_tree().get_first_node_in_group("player")
	setup_chances()
	
func get_action() -> EnemyAction:
	var action := get_first_conditional_action()#获取第一个条件行动
	if action:
		return action
		
	return get_chance_based_action()
	
func get_first_conditional_action() -> EnemyAction:
	var action: EnemyAction
	
	for child in get_children():
		action = child as EnemyAction
		if not action or action.type != EnemyAction.Type.CONDITIONAL:#如果不是行为或者不是条件行为
			continue
		
		if action.is_performable():
			return action
			
	return null#没有找到一个可以执行的条件行动

func get_chance_based_action() -> EnemyAction:#执行基于概率的行动
	var action: EnemyAction
	var roll := randf_range(0.0, total_weight)
	
	for child in get_children():
		action = child as EnemyAction
		if not action or action.type != EnemyAction.Type.CHANCE_BASED:
			continue
		
		if action.accumulated_weight > roll:#检查累计权重是否大于骰子
			return action#返回这个行动
	
	return null#没有则返回null

func setup_chances() -> void:
	var action: EnemyAction
	
	for child in get_action():
		action = child as EnemyAction
		if not action or action.type != EnemyAction.Type.CHANCE_BASED:#如果不是有效行动或者不是基于概率的行动
			continue
		
		total_weight += action.chance_weight #如果是，则在总权重中加上这个行动的权重
		action.accumulated_weight = total_weight #把每个行动的累积权重修改为目前的总权重

func _set_enemy(value: Enemy) -> void:
	enemy = value
	for action in get_children():
		action.enemy = enemy
		
func _set_target(value: Node2D) -> void:
	target = value
	
	for action in get_children():
		action.target = target
