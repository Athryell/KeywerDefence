extends Area2D
class_name BaseBullet

@export var DMG = 1
@export var SPEED = 50
@export var impact_sprite: Texture2D
@export var impact_particles: PackedScene

var RANGE = 1500
var travelled_distance = 0

func _ready():
	pass

func _physics_process(delta):
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()


func play_impact():
	if impact_sprite:
		pass
	if impact_particles:
		pass
