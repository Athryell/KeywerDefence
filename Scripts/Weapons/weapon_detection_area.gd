extends BaseWeapon
class_name WeaponDetectionArea

@onready var area = $DetectionArea


func _key_press_override():
	_shoot()


func _shoot():
	var enemies_in_range = area.get_overlapping_areas()
	if enemies_in_range.size() == 0:
		return
	elif enemies_in_range.size() == 1:
		_target = enemies_in_range[0]
	else:
		_target = findClosestEnemy(enemies_in_range)
		
	var new_bullet = bulletScene.instantiate()
	new_bullet.position = global_position
	new_bullet.look_at(_target.global_position)
	
	bulletsContainer.add_child(new_bullet)


func findClosestEnemy(enemies: Array) -> Object:
	var closest_enemy = null
	var closest_distance = INF
	for enemy in enemies:
		var distance = global_position.distance_to(enemy.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = enemy
	return closest_enemy
