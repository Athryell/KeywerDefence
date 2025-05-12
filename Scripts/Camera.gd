extends Camera2D

@export var transition_offset_y: int

@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready():
	position = get_viewport_rect().size * 0.5
	StateMachine.started_transition_to_workshop.connect(Callable(self, "_on_start_transition_to_workshop"))
	StateMachine.started_transition_from_workshop.connect(Callable(self, "_on_start_transition_from_workshop"))

func _on_start_transition_to_workshop():
	anim.play("game_to_workshop")
	await anim.animation_finished
	StateMachine.change_state(StateMachine.GameState.WORKSHOP)
	
	
func _on_start_transition_from_workshop():
	anim.play_backwards("game_to_workshop")
	await anim.animation_finished
	StateMachine.change_state(StateMachine.GameState.GAME_SCREEN)
