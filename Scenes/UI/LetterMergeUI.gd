extends Control

var alphabet := ["ABCDEFGHIJKLMNOPQRSTUVWXYZ"]
var letter_btn = preload("res://Scenes/UI/letter_button.tscn")
var letter_scene = preload("res://Scenes/UI/draggable_letter.tscn")

var letters = {
	"left": "",
	"left_rot": 0,
	"right": "",
	"right_rot": 0
}

var left_letter := ""
var left_letter_rot := 0
var right_letter := ""
var right_letter_rot := 0

func _ready():
	display_alphabet()
	$LeftButton.letter_dropped.connect(_on_letter_dropped)
	$RightButton.letter_dropped.connect(_on_letter_dropped)


func display_alphabet():
	print(left_letter)
	for letter in alphabet[0]:
		var new_btn = letter_btn.instantiate()
		new_btn.text = letter
		new_btn.name = "LetterButton_" + letter
		if not letter in GameManager.get_discovered_letters():
			new_btn.self_modulate = Color(Color.WHITE, 0.5)
			new_btn.disabled = true
		new_btn.letter_chosen.connect(_on_letter_chosen)
		$MarginContainer/AlphabetContainer.add_child(new_btn)

func update_alphabet(letter):
	var button = "LetterButton_" + letter
	var node = $MarginContainer/AlphabetContainer.get_node(button)
	node.self_modulate = Color(Color.WHITE, 1)
	node.disabled = false


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		UiInteractionManager.	current_letter_held.rotation += deg_to_rad(90) #TODO: tween/lerp 
		
		UiInteractionManager.current_letter_held_rot += 90
		if UiInteractionManager.current_letter_held_rot == 360:
			UiInteractionManager.current_letter_held_rot = 0
		


func _on_letter_dropped(btn_name):
	if btn_name == "LeftButton":
		left_letter = UiInteractionManager.current_letter_held.text
		left_letter_rot = UiInteractionManager.current_letter_held_rot
	elif btn_name == "RightButton":
		right_letter = UiInteractionManager.current_letter_held.text
		right_letter_rot = UiInteractionManager.current_letter_held_rot
	UiInteractionManager.current_letter_held.queue_free()
	UiInteractionManager.current_letter_held = null
	UiInteractionManager.current_letter_held_rot = 0
	
	check_if_letter_is_discovered()


func _on_letter_chosen(text):
	var draggable_letter = letter_scene.instantiate()
	draggable_letter.text = text
	add_child(draggable_letter)
	UiInteractionManager.current_letter_held = draggable_letter


func check_if_letter_is_discovered():
	if not left_letter or not right_letter:
		if (left_letter == "W" and right_letter == "") or (left_letter == "" and right_letter == "W"):
			# Letter "M" is discovered!
			discover_letter("M")
		return
	
	if left_letter == right_letter:
		if left_letter != "U": #manage "O" or "S"
			return
	
	var alphabet_combs = UiInteractionManager.combinations
	
	for resulting_letter in alphabet_combs:
		for index in range(alphabet_combs[resulting_letter].size()):
			var current_comb = alphabet_combs[resulting_letter][index]
			
			#if left_letter == "I":
				#adjust_rotation_horizontal(left_letter)
				#adjust_rotation_vertical(left_letter)
			#if right_letter == "I":
				#adjust_rotation_horizontal(right_letter)
				#adjust_rotation_vertical(right_letter)
			
			# Checks if letters in left and right slot are in the combination and have the correct rotation
			if left_letter in current_comb and current_comb[left_letter] == left_letter_rot and right_letter in current_comb and current_comb[right_letter] == right_letter_rot:
				# Checks if D has already been found and gets the P
				if resulting_letter in GameManager.get_discovered_letters():
					# TODO: highlight already found letter
					print("Letter already found!")
					return
				
				discover_letter(resulting_letter)
				return

func discover_letter(letter):
	GameManager.add_discovered_letter(letter)
	print(GameManager.get_discovered_letters())
	update_alphabet(letter)
	reset_dropping_areas()


func reset_dropping_areas():
	$LeftButton.clear_label()
	$RightButton.clear_label()
	right_letter = ""
	right_letter_rot = 0
	left_letter = ""
	left_letter_rot = 0


#func adjust_rotation_horizontal(pos_letter):
	#var side_of_letter = pos_letter + "_rot"
	#letters[side_of_letter] = 90
#
#
#func adjust_rotation_vertical(pos_letter):
	#var side_of_letter = pos_letter + "_rot"
	#letters[side_of_letter] = 0
	
