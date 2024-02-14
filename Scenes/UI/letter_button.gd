extends Button

signal letter_chosen(text)

func _on_button_down():
	if not UiInteractionManager.current_letter_held:
		emit_signal("letter_chosen", text)

