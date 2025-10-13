extends Node

#卡牌相关的事件
signal card_drag_started(card_ui: CardUI)
signal card_drag_ended(card_ui: CardUI)
signal card_played(card: Card)
signal card_aim_started(card_ui: CardUI)
signal card_aim_ended(card_ui: CardUI)
signal card_tooltip_requested(card: Card)
signal tooltip_hide_requested

#玩家相关的事件
signal player_hand_drawn
signal player_hand_discarded
signal player_turn_ended

#敌人相关的事件
signal enemy_action_completed(enemy: Enemy)
signal enemy_turn_ended
