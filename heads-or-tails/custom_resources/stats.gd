class_name  Stats
extends Resource

signal stats_changed

@export var max_health := 1
@export var art: Texture

var health: int : set = set_health
var block: int : set = set_block

func set_health(value : int) -> void:
	health = clampi(value, 0, max_health)#限制value在0和最大生命值之间
	stats_changed.emit()#发送信号

func set_block(value : int) -> void:
	block = clampi(value , 0, 999)
	stats_changed.emit()

func take_damage(damage : int) -> void:#这里的damage是敌人造成的伤害
	if damage <= 0:
		return
	var initial_damage = damage#敌人造成的伤害
	damage = clampi(damage - block, 0, damage)#这里的damage变成了血量收到的伤害
	self.block = clampi(block - initial_damage, 0, block)
	self.health -= damage#这里可能会变成负数，暂定


func heal(amount : int) -> void:
	self.health += amount

func create_instance() -> Resource:#一般表示创建实例
	var instance: Stats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	return instance
