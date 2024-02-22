extends Node

var starting_letters = "I"
var _letters_discovered = ["L", "T", "F"] #"V", "U", "C", "S", "W"

var is_merger_open := false

func _ready():
	add_discovered_letter(starting_letters)

func get_discovered_letters():
	return _letters_discovered

func add_discovered_letter(letter):
	_letters_discovered.append(letter)


func _input(event):
	if event.is_action_pressed("open_merger"):
		if event.pressed and not event.echo:
			is_merger_open = not is_merger_open
		
		if is_merger_open:
			get_tree().change_scene_to_file("res://Scenes/UI/LetterMergeUI.tscn")
		else:
			get_tree().change_scene_to_file("res://Scenes/main.tscn")

