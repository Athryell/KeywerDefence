extends BaseBullet

@export var ROTATION_SPEED: int = 2

@onready var sprites := $Sprites

func _physics_process(delta):
	super(delta)
	
	sprites.rotation += ROTATION_SPEED * delta
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta


func _on_area_entered(area):
	play_impact()
	if area.has_method("take_damage"):
		area.take_damage(DMG)

