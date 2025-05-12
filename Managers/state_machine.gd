extends Node

enum GameState { 
	WORKSHOP,
	DEFENDING,
	MERGING_LETTERS,
	MAIN_MENU,
	GAME_SCREEN,
	TRANSITION_TO_WORKSHOP,
	TRANSITION_FROM_WORKSHOP, }
	
var current_state: GameState = GameState.GAME_SCREEN

signal started_defending
signal started_merging_letters
signal started_workshop
signal started_main_menu
signal started_game_screen
signal started_transition_to_workshop
signal started_transition_from_workshop

func change_state(new_state: GameState) -> void:
	match current_state: #Exit the state
		GameState.DEFENDING:
			print("Exit DEFENDING State")
		GameState.MERGING_LETTERS:
			print("Exit MERGIN_LETTERS State")
		GameState.TRANSITION_TO_WORKSHOP:
			print("Exit TRANSITION_TO_WORKSHOP State")
		GameState.TRANSITION_FROM_WORKSHOP:
			print("Exit TRANSITION_FROM_WORKSHOP State")
		GameState.WORKSHOP:
			print("Exit WORKSHOP State")
		GameState.MAIN_MENU:
			print("Exit MAIN_MENU State")
		GameState.GAME_SCREEN:
			print("Exit GAME_SCREEN State")
	
	current_state = new_state
	
	match new_state: #Enter the state
		GameState.TRANSITION_TO_WORKSHOP:
			print("Entered TRANSITION_TO_WORKSHOP State")
			emit_signal("started_transition_to_workshop")
		GameState.TRANSITION_FROM_WORKSHOP:
			print("Entered TRANSITION_FROM_WORKSHOP State")
			emit_signal("started_transition_from_workshop")
		GameState.WORKSHOP:
			print("Entered WORKSHOP State")
			emit_signal("started_workshop")
		GameState.DEFENDING:
			print("Entered DEFENDING State")
			emit_signal("started_defending") #StateMachine.start_defending.connect(Callable(self, "_on_start_defending"))
		GameState.MERGING_LETTERS:
			print("Entered MERGIN_LETTERS State")
			get_tree().change_scene_to_file("res://Scenes/UI/letter_merge_ui.tscn")
			emit_signal("started_merging_letters")
		GameState.MAIN_MENU:
			print("Entered MAIN_MENU State")
			emit_signal("started_main_menu")
		GameState.GAME_SCREEN:
			print("Entered GAME_SCREEN State")
			get_tree().change_scene_to_file("res://Scenes/main.tscn")
			emit_signal("started_game_screen")
