extends Node2D

@export var SPEED: float = 80
@export var STARTING_HEALTH: float
var health: float

func _ready():
	health = STARTING_HEALTH
	
func _process(delta):
	position += Vector2.DOWN * SPEED * delta

func take_damage(amount: float):
	health -= amount
	
	if health <= 0:
		queue_free()
	
