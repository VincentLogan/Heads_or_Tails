# GlobalSignals.gd - 添加到AutoLoad自动加载
extends Node

# 定义卡牌特效信号
signal card_effect_triggered(effect_data)

# 在游戏中任何地方都可以发射这个信号
func trigger_card_effect(effect_data):
	emit_signal("card_effect_triggered", effect_data)
