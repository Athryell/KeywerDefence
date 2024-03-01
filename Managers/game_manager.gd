extends Node

var starting_letters = "I"
var _letters_discovered = ["L", "T", "F", "X", "E", "V"] #"U", "C", "S", "W"

@onready var game_state = StateMachine

func _ready():
	add_discovered_letter(starting_letters)

func get_discovered_letters():
	return _letters_discovered

func add_discovered_letter(letter):
	_letters_discovered.append(letter)


func _input(event): 
	if event.is_action_pressed("debug_gameState1"): #TODO: debug
		if event.pressed and not event.echo:
			game_state.change_state(game_state.GameState.DEFENDING)
	if event.is_action_pressed("debug_gameState2"):  #TODO: debug
		if event.pressed and not event.echo:
			game_state.change_state(game_state.GameState.MERGING_LETTERS)
	if event.is_action_pressed("debug_gameState3"):  #TODO: debug
		if event.pressed and not event.echo:
			game_state.change_state(game_state.GameState.PLACING_KEYS)
	if event.is_action_pressed("debug_gameState4"):  #TODO: debug
		if event.pressed and not event.echo:
			game_state.change_state(game_state.GameState.MAIN_MENU)
		
