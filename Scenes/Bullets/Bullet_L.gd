extends BaseBullet
	
	
func _ready():
	super()
	
	var rand_rot = randf_range(-10, 10)
	rotation += deg_to_rad(rand_rot)
	scale *= randf_range(0.5, 2)
	
func _physics_process(delta):
	super(delta)
	
	var direction = Vector2.RIGHT.rotated(rotation).normalized()
	position += direction * SPEED * delta


func _on_area_entered(area):
	play_impact()
	queue_free()
	if area.has_method("take_damage"):
		area.take_damage(DMG)
