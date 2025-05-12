extends CanvasLayer

@onready var btn_next_wave = $BtnNextWave
@onready var btn_merge = $BtnMerge
@onready var btn_workshop = $BtnWorkshop


func _ready():
	StateMachine.started_workshop.connect(_change_workshop_btn_text)
	StateMachine.started_game_screen.connect(_change_workshop_btn_text)


func _on_btn_next_wave_button_down():
	StateMachine.change_state(StateMachine.GameState.DEFENDING)


func _on_btn_merge_button_down():
	StateMachine.change_state(StateMachine.GameState.MERGING_LETTERS)


func _on_btn_workshop_button_down():
	match StateMachine.current_state:
		StateMachine.GameState.GAME_SCREEN:
			StateMachine.change_state(StateMachine.GameState.TRANSITION_TO_WORKSHOP)
		StateMachine.GameState.WORKSHOP:
			StateMachine.change_state(StateMachine.GameState.TRANSITION_FROM_WORKSHOP)



func _change_workshop_btn_text():
	var btn_text: String
	match StateMachine.current_state:
		StateMachine.GameState.GAME_SCREEN:
			btn_text = "Go to Workshop"
		StateMachine.GameState.WORKSHOP:
			btn_text = "Ready to fight"
	
	btn_workshop.text = btn_text
	
