extends CenterContainer

var letter: String

func init(text):
	letter = text
	$Label.text = text
	$Label.set("theme_override_colors/font_color", Color(Color.WHITE, 0.2))

func set_as_discovered():
	$Label.set("theme_override_colors/font_color", Color(Color.WHITE, 1))

func _get_drag_data(at_position):
	var mydata = {}
	mydata["letter"] = letter
	set_preview()
	#UiInteractionManager.current_letter_held = letter
	print("Can", at_position)
	
	
func _can_drop_data(position, data):
	print("Can drop data called at position: ", position, " with data: ", data)
	# Qui puoi inserire la logica per determinare se i dati possono essere rilasciati
	# Ad esempio, puoi controllare il tipo di dati o altre condizioni
	return true  # o false a seconda della tua logica

func _drop_data(position, data):
	print("Drop data called at position: ", position, " with data: ", data)
	# Qui elabori i dati rilasciati
	# Ad esempio, potresti voler aggiungere l'oggetto trascinato a un inventario o cambiarne la posizione
	
func set_preview():
	var draggable_letter = UiInteractionManager.draggable_letter.instantiate()
	draggable_letter.text = letter
	get_tree().get_root().add_child(draggable_letter)
