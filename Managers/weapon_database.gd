extends Node

var cache: Dictionary = {}

var weapons_folder = "res://Resources/Weapons/"

func _ready():
	var folder = DirAccess.open(weapons_folder)
	folder.list_dir_begin()
	
	var file_name = folder.get_next()
	
	while file_name != "":
		cache[file_name] = load(weapons_folder + "/" + file_name)
		file_name = folder.get_next()


func get_weapon(letter_weapon) -> Resource:
	var weapon_resource = "Weapon_" + letter_weapon + ".tres"
	if cache.has(weapon_resource):
		return cache[weapon_resource]
	else:
		print("Doesn't exist a resource for " + letter_weapon)
		return null
