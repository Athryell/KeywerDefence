extends Area2D

var _target

@onready var parent = get_parent()

func key_press():
	_shoot()


func _shoot():
	var enemies_in_range = get_overlapping_areas()
	match enemies_in_range.size():
		0:
			return
		1:
			_target = enemies_in_range[0]
		_:
			_target = _findClosestEnemy(enemies_in_range)
	
	var new_bullet = parent.bullet_scene.instantiate()
	new_bullet.position = global_position
	new_bullet.look_at(_target.global_position)
	
	parent.bulletsContainer.add_child(new_bullet)


func _findClosestEnemy(enemies: Array) -> Object:
	var closest_enemy = null
	var closest_distance = INF
	for enemy in enemies:
		var distance = global_position.distance_to(enemy.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = enemy
	return closest_enemy
