extends BaseWeapon

@onready var area = $WeaponArea2D

func shoot():
	var enemies_in_range = area.get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		print("Enemy!")
		#var target_enemy = enemies_in_range[0]
		#look_at(target_enemy.global_position)
	var new_bullet = bulletScene.instantiate()
	new_bullet.position = position
	#new_bullet.look_at(target_enemy.global_position)
	add_child(new_bullet)
