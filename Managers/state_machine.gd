extends Node

enum GameState { PLACING_KEYS, DEFENDING, MERGING_LETTERS, MAIN_MENU}
var current_state: GameState = GameState.PLACING_KEYS

signal started_defending
signal started_merging_letters
signal started_placing_keys
signal started_main_menu

func change_state(new_state: GameState) -> void:
	match current_state: #Exit the state
		GameState.DEFENDING:
			print("Exit DEFENDING State")
		GameState.MERGING_LETTERS:
			print("Exit MERGIN_LETTERS State")
		GameState.PLACING_KEYS:
			print("Exit PLACING_KEYS State")
		GameState.MAIN_MENU:
			print("Exit MAIN_MENU State")
	
	current_state = new_state
	
	match new_state: #Enter the state
		GameState.PLACING_KEYS:
			print("Entered PLACING_KEYS State")
			get_tree().change_scene_to_file("res://Scenes/main.tscn")
			emit_signal("started_placing_keys")
		GameState.DEFENDING:
			print("Entered DEFENDING State")
			emit_signal("started_defending") #StateMachine.start_defending.connect(Callable(self, "_on_start_defending"))
		GameState.MERGING_LETTERS:
			print("Entered MERGIN_LETTERS State")
			get_tree().change_scene_to_file("res://Scenes/UI/LetterMergeUI.tscn")
			emit_signal("started_merging_letters")
		GameState.MAIN_MENU:
			print("Entered MAIN_MENU State")
			emit_signal("started_main_menu")
