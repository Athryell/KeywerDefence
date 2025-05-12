class_name KeyScene
extends Node2D

var weapon

var _key_input_bind: String
var _keyboard_coordinates := Vector2.ZERO
var _new_weapon

@onready var drop_area = $DropArea
@onready var col = $DropArea/CollisionShape2D
@onready var crosshair = $Crosshair


func _process(delta):
	if Input.is_action_just_pressed(_key_input_bind):
		if weapon:
			weapon.key_press()
	elif Input.is_action_pressed(_key_input_bind):
		if weapon:
			weapon.key_held(delta)
	elif Input.is_action_just_released(_key_input_bind):
		if weapon:
			weapon.key_released()


func initialize(letter, pos, width):
	name = "key_" + letter
	
	_keyboard_coordinates = pos
	_key_input_bind = letter.to_upper()
	_set_drop_area(width)

	if letter in GameManager.get_discovered_letters():
		add_letter_weapon(letter)
	else:
		add_base_weapon()


func add_letter_weapon(letter: String):
	_remove_weapon()
	var weapon_path = load("res://Scenes/Weapons/weapon_" + letter.to_lower() + ".tscn")
	_add_weapon(weapon_path, letter)
	


func add_base_weapon():
	_remove_weapon()
	var weapon_path = load("res://Scenes/Weapons/base_weapon.tscn")
	_add_weapon(weapon_path)


func _add_weapon(path: PackedScene, letter:String = _key_input_bind.to_lower()):
	if not path:
		push_error("No weapon found!")
		return
	weapon = path.instantiate() as Node2D
	weapon.weapon_letter = letter #hack? is this needed here? Maybe remove and set in tscn, need to refactor from inheritance to components
	# TODO NEXT need to refactor and put all the base stuff in base_weapon gd and then add components (with scripts) for charge, area ecc
	# in base weapon set default sprite to override
	
	weapon.set_position_on_keyboard(_keyboard_coordinates) #hack? is this needed both here and in key?
	add_child(weapon)


func _remove_weapon():
	if weapon:
		weapon.queue_free()
	weapon = null


func _set_drop_area(width):
	col.shape.size = Vector2.ONE * width
	drop_area.monitoring = false


func _on_drop_area_mouse_entered():
	if StateMachine.current_state == StateMachine.GameState.WORKSHOP:
		crosshair.visible = true
		WorkshopManager.set_hovering_key(self)


func _on_drop_area_mouse_exited():
	if StateMachine.current_state == StateMachine.GameState.WORKSHOP:
		crosshair.visible = false
		if WorkshopManager.get_hovering_key() == self:
			WorkshopManager.set_hovering_key(null)


func _on_drop_area_input_event(viewport, event, shape_idx):
	if StateMachine.current_state == StateMachine.GameState.WORKSHOP and event.is_action_pressed("mouse_left"):
		if not weapon.name == "BaseWeapon":
			WorkshopManager.instantiate_dragging_keycap(weapon.weapon_letter)
			add_base_weapon()
