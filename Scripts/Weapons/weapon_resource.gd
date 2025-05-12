#class_name Weapon
#extends Resource
#
#@export var weaponName: String
#@export var testSprite: Texture2D
#@export_multiline var description
#
#@export_category("Bullet Props")
#@export var bulletScene: PackedScene
#@export var bulletSpeed: float
#@export var bulletImpact: Texture2D
#@export var damage: int
#@export var speed: float
#@export var recharge_time: float
#@export var area_range: float = 0
#
#var is_weapon_active: bool
#
#var _weaponLetter: String
#var _canShoot: bool
#
#func shoot():
	#if is_weapon_active:
		#print("'_shootBullet' no implemented for", weaponName)
