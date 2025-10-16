class_name CharacterStats
extends Stats

@export var starting_deck: CardPile #起始牌堆
@export var cards_per_turn: int #每回合牌数
@export var max_mana: int #最大法力值

var mana: int : set = set_mana
var deck: CardPile
var discard: CardPile
var draw_pile: CardPile

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
	
	#初始化幸运币，战斗开始重置
	#instance.luck_coin = 0
	#或者设置为默认值
	instance.luck_coin = instance.luck_coin_default
	return instance
