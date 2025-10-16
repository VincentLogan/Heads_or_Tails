class_name  Stats
extends Resource

signal stats_changed
signal luck_coin_changed(value: int)#幸运币机制

@export var max_health := 1
@export var art: Texture
@export var luck_coin_default := 0 #资源默认值

var health: int : set = set_health
var block: int : set = set_block
var luck_coin := 0 : set = set_luck_coin#引入幸运币

func set_health(value : int) -> void:
	health = clampi(value, 0, max_health)#限制value在0和最大生命值之间
	stats_changed.emit()#发送信号

func set_block(value : int) -> void:
	block = clampi(value , 0, 999)
	stats_changed.emit()

func set_luck_coin(value: int) -> void:
	luck_coin = clamp(value, -10, 10) #自定义问题后期再调试
	stats_changed.emit()#保证幸运币和其他属性一样发射信号,给UI使用？
	luck_coin_changed.emit(luck_coin)#单独的幸运币变更信号

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
	var instance: Stats = self.duplicate()#该函数是创建了一个自己节点的副本
	instance.health = max_health
	instance.block = 0
	#下面初始化幸运币
	if has_method("luck_coin"):#可选的保险措施
		instance.luck_coin = luck_coin_default
	else:
		#可以直接赋值
		instance.luck_coin = luck_coin_default
	return instance
