extends Node

var _alphabet := ["ABCDEFGHIJKLMNOPQRSTUVWXYZ"]
var _starting_letters = "I"
var _letters_discovered = ["L", "T", "F", "X", "E", "V"] #"U", "C", "S", "W"
#var _alphabet_amount_for_workshop = {}
var _key_positions = {}

@onready var game_state = StateMachine

func _ready():
	add_discovered_letter(_starting_letters)


func get_discovered_letters():
	return _letters_discovered


func add_discovered_letter(letter):
	_letters_discovered.append(letter)


#func set_key_global_position(key: String, pos: Vector2) -> void:
	#_key_positions[key.to_upper()] = pos


#func get_key_global_position(key_letter) -> Vector2:
#
	#var keyboard = %Keyboard
	#var key_to_find = "key_" + key_letter
	#var key = keyboard.find_child(key_to_find) as Node2D
	#return key.global_position

#func add_letter_in_workshop(letter, amount_to_add):
	#_alphabet_amount_for_workshop[letter] += amount_to_add
#
#func get_letters_in_workshop() -> Dictionary:
	#return _alphabet_amount_for_workshop
