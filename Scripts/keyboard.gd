extends Node2D

const key_scene := preload("res://Scenes/key.tscn")
const KEY_DIMENSIONS := 57
var keyboard_layout = [
	"QWERTYUIOP",
	"ASDFGHJKL",
	"ZXCVBNM"
]


func _ready():
	init_keyboard()
	center_keyboard()

func init_keyboard():
	for row in range(keyboard_layout.size()):
		for col in range(keyboard_layout[row].length()):
			var letter = keyboard_layout[row][col]
			var keyboard_coordinates = Vector2(col, row)
			
			var new_key = key_scene.instantiate() as KeyScene
			add_child(new_key)
			new_key.initialize(letter, keyboard_coordinates, KEY_DIMENSIONS)

			new_key.position.x = col * KEY_DIMENSIONS + row * 19 #hack magic number
			new_key.position.y = row * KEY_DIMENSIONS
			#GameManager.set_key_global_position(letter, new_key.global_position)


func center_keyboard():
	var keyboard_width = keyboard_layout[0].length() * KEY_DIMENSIONS
	var keyboard_height = keyboard_layout.size() * KEY_DIMENSIONS
	var offset = KEY_DIMENSIONS * 0.5
	var screen_size = get_viewport_rect().size

	position.x = (screen_size.x * 0.5) - keyboard_width * 0.5 + offset
	position.y = (screen_size.y) - (keyboard_height + offset)


func get_letter_global_position(letter_of_key):
	var key_to_find = "key_" + letter_of_key.to_upper()
	var key = find_child(key_to_find, false, false) as Node2D
	return key.global_position
