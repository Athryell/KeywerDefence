extends Node2D

const key_scene := preload("res://Scenes/key.tscn")
const KEY_DIMENSIONS := 57


func _ready():
	init_keyboard()


func init_keyboard():
	var keyboard_layout = [
		"QWERTYUIOP",
		"ASDFGHJKL",
		"ZXCVBNM"
	]

	for row in range(keyboard_layout.size()):
		for col in range(keyboard_layout[row].length()):
			var letter = keyboard_layout[row][col]
			var new_key = key_scene.instantiate() as KeyScene
			new_key.name = "Key_" + letter
			new_key.set_button_bind(letter)
			new_key.position.x = col * KEY_DIMENSIONS + row * 18
			new_key.position.y = row * KEY_DIMENSIONS

			if letter in GameManager.get_discovered_letters():
				new_key.set_weapon(letter)
			
			add_child(new_key)
	
	


