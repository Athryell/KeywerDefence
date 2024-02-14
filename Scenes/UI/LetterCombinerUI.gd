extends Control

var alphabet := ["ABCDEFGHIJKLMNOPQRSTUVWXYZ"]
var letter_alphabet = preload("res://Scenes/UI/letter_alphabet.tscn")

#
#var left_letter: String
#var left_letter_rot: int
#var right_letter: String
#var right_letter_rot: int

func _ready():
	display_alphabet()
#	$LeftButton.letter_dropped.connect(_on_letter_dropped)
#	$RightButton.letter_dropped.connect(_on_letter_dropped)


func display_alphabet():
	for letter in alphabet[0]:
		var new_letter = letter_alphabet.instantiate()
		new_letter.name = "Letter_" + letter
		new_letter.init(letter)
		if letter in GameManager.get_discovered_letters():
			new_letter.set_as_discovered()
			
#		new_letter.letter_chosen.connect(_on_letter_chosen)
		$MarginContainer/AlphabetContainer.add_child(new_letter)


#func update_alphabet(letter):
	#var button = "LetterButton_" + letter
	#var node = $MarginContainer/AlphabetContainer.get_node(button)
	#node.self_modulate = Color(Color.WHITE, 1)
	#node.disabled = false


#func _input(event):
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		#UiInteractionManager.current_letter_held.rotation += deg_to_rad(90) #TODO: tween/lerp 
		#
		#UiInteractionManager.current_letter_held_rot += 90
		#if UiInteractionManager.current_letter_held_rot == 360:
			#UiInteractionManager.current_letter_held_rot = 0
		


#func _on_letter_dropped(btn_name):
	#if btn_name == "LeftButton":
		#left_letter = UiInteractionManager.current_letter_held.text
		#left_letter_rot = UiInteractionManager.current_letter_held_rot
	#elif btn_name == "RightButton":
		#right_letter = UiInteractionManager.current_letter_held.text
		#right_letter_rot = UiInteractionManager.current_letter_held_rot
	#UiInteractionManager.current_letter_held.queue_free()
	#UiInteractionManager.current_letter_held = null
	#UiInteractionManager.current_letter_held_rot = 0
	#
	#check_if_letter_is_discovered()


func _on_letter_chosen(text):
	#var draggable_letter = letter_scene.instantiate()
	#draggable_letter.text = text
	#add_child(draggable_letter)
	#UiInteractionManager.current_letter_held = draggable_letter
	pass


#func check_if_letter_is_discovered():
	#if not left_letter or not right_letter:
		#return
	#
	#if left_letter == right_letter:
		#if left_letter != "U":
			#return
	
	#var combs = UiInteractionManager.combinations
	#var new_letter
	#
	#for c in combs:
		#if left_letter in combs[c] and combs[c][left_letter] == left_letter_rot:
			#if right_letter in combs[c] and combs[c][right_letter] == right_letter_rot:
				#new_letter = c


	#if new_letter:
		#GameManager.add_discovered_letter(new_letter)
		#update_alphabet(new_letter)
