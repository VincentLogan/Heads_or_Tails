extends Node

#Card_related events
#这里应该还有几个signal，应该是第5集的
#signal card_drag_started(card_ui: CardUI)
#signal card_drag_ended(card_ui: CardUI)
#signal card_played(card: Card)
signal card_aim_started(card_ui: CardUI)
signal card_aim_ended(card_ui: CardUI)
signal card_tooltip_requested(card: Card)
signal tooltip_hide_requested

# Player-related events
signal player_hand_drawn
signal player_hand_discarded
signal player_turn_ended
