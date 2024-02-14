extends Button

signal letter_dropped(btn_name)

func _on_button_down():
	if UiInteractionManager.current_letter_held:
		$BtnLabel.text = UiInteractionManager.current_letter_held.text
		$BtnLabel.rotation = UiInteractionManager.current_letter_held.rotation
		emit_signal("letter_dropped", name)

func clear_label():
	$BtnLabel.text = ""
	$BtnLabel.rotation = 0
