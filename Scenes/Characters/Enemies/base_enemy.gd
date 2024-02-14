extends Node2D

@export var STARTING_HEALTH: float
var health: float

func _ready():
	health = STARTING_HEALTH
	
func _process(delta):
	position += Vector2.DOWN * 100 * delta

func damage(amount: float):
	health -= amount
	
	if health <= 0:
		queue_free()
	
