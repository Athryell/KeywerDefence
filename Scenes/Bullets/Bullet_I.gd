extends Area2D

@export var SPEED = 1000
@export var RANGE = 3200
var travelled_distance = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()


func _on_area_entered(area):
	queue_free()
	if area.has_method("take_damage"):
		area.take_damage()
