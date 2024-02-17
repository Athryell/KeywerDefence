extends BaseWeapon

@onready var area = $DetectionArea
@onready var bulletsContainer = get_tree().get_root().get_node("/root/Main/bullets_container")


func shoot():
	var enemies_in_range = area.get_overlapping_areas()
	if enemies_in_range.size() == 0:
		return
		
	print("Enemy!")
	var target_enemy = enemies_in_range[0]
	var new_bullet = bulletScene.instantiate()
	new_bullet.position = global_position
	new_bullet.look_at(target_enemy.global_position)
	
	bulletsContainer.add_child(new_bullet)
