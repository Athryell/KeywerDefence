extends Button


func _on_button_down():
	StateMachine.change_state(StateMachine.GameState.DEFENDING)
