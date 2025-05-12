extends BaseBullet

@export var ROTATION_SPEED: int
@export var MAX_DISTANCE: int

@onready var sprites := $Sprites

var starting_pos: Vector2
var direction: Vector2

func _ready():
	starting_pos = global_position
	direction = Vector2.RIGHT.rotated(rotation)


func _physics_process(delta):
	sprites.rotation += ROTATION_SPEED * delta
	
	travelled_distance += SPEED * delta

	if travelled_distance < MAX_DISTANCE:
		position += direction * SPEED * delta
	else:
		position -= direction * SPEED * delta
		
		if position == starting_pos:
			queue_free()


func _on_area_entered(area):
	play_impact()
	if area.has_method("take_damage"):
		area.take_damage(DMG)
