extends Node

const enemy := preload("res://Scenes/Characters/Enemies/base_enemy.tscn")
@onready var timer = $Timer 

func _ready():
	StateMachine.started_defending.connect(Callable(self, "_on_start_defending"))

func _on_start_defending():
	timer.start()
	
	
func _on_timer_timeout():
	var new_enemy = enemy.instantiate()
	new_enemy.position = Vector2(randi_range(0, get_viewport().size.x), +10)
	add_child(new_enemy)
