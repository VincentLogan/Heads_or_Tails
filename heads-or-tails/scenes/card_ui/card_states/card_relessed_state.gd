extends CardState

var played: bool

func enter() -> void:
	card_ui.color.color = Color.DARK_VIOLET
	card_ui.state.text = "RELEASED"#这里好像要删掉

	played = false
	
	if not card_ui.targets.is_empty():
		Events.tooltip_hide_requested.emit()
		played = true
		print("play card for target(s)", card_ui.targets)#这里好像要删掉，改成card_ui.play()
		
func  on_input(_event: InputEvent) -> void:
	if played:
		return
	 
	transition_requested.emit(self, CardState.State.BASE)
