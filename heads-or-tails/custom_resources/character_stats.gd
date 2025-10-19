class_name CharacterStats
extends Stats

enum {v_low_luck, low_luck, high_luck, v_high_luck}

@export var starting_deck: CardPile #起始牌堆
@export var cards_per_turn: int #每回合牌数
@export var max_mana: int #最大行动值

var mana: int : set = set_mana
var deck: CardPile
var discard: CardPile
var draw_pile: CardPile
var luck_coins: int = 50 : set = set_luck #幸运
var LUCK_MIN := 0
var LUCK_MAX := 100
var luck_locked: bool = false
var can_effect_true: bool = false
var prime_luck_coins: int = 0
var super_luck_mode := false
var luck_down_locked := false

func set_luck(value: int) -> void:
	luck_coins = clamp(value, LUCK_MIN, LUCK_MAX)
	stats_changed.emit()

func set_mana(value: int) -> void:
	mana = value
	stats_changed.emit()

func reset_mana() -> void:
	self.mana = max_mana

func take_damage(damage : int) -> void:
	var initial_health := health
	super.take_damage(damage)
	if initial_health > health:
		Events.player_hit.emit()

func add_luck(amount: int) -> void:
	if not luck_locked:#注意：如果你想在tier变化时发信号，可以在这里记录旧tier
		if luck_down_locked:
			if amount < 0:
				return 
			else:
				set_luck(luck_coins + amount)
		else:
			set_luck(luck_coins + amount)
		emit_signal("stats_changed")
	#举例发tier变化（需要量子值时调用者自行处理）

func get_luck():#获取当前幸运币
	if luck_coins < 25:
		return v_low_luck
	elif luck_coins >= 25 and luck_coins < 50:
		return low_luck
	elif luck_coins >= 50 and luck_coins < 75:
		return high_luck
	elif luck_coins >= 75 and luck_coins < 100:
		return v_high_luck

func can_play_card(card: Card) -> bool:
	return mana >= card.cost #应该是个bool值

func create_instance() -> Resource:
	var instance: CharacterStats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	instance.reset_mana()
	instance.deck = instance.starting_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard = CardPile.new()
	return instance

func _unlock_luck():
	luck_locked = false
