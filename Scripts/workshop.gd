class_name Workshop
extends Node2D

@export_range(0, 30, 1) var rand_rot_amount = 20

var _boundaries
var _draggable_keycap = preload("res://Scenes/weapon_workshop.tscn")
var keycaps_in_workshop = []

@onready var drop_area = $DropArea/CollisionShape2D
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var keyboard = %Keyboard

var temp_positions = [] # to avoid overlap

func _ready():
	_boundaries = drop_area.shape.extents

func display_keycaps():
	if StateMachine.current_state == StateMachine.GameState.TRANSITION_FROM_WORKSHOP:
		return
	
	var letters_and_amount = WorkshopManager.get_letters_in_workshop()
	
	for l in letters_and_amount:
		if  letters_and_amount[l] > 0:
			var keycap = instantiate_keycap(l)
			
			var overlap_distance = keycap.get_node("CollisionShape2D").shape.size.x * 2
			var rand_pos = Vector2(randi_range(- _boundaries.x, _boundaries.x), randi_range(-_boundaries.y, _boundaries.y))
			while _is_overlapping(rand_pos, overlap_distance):
				rand_pos = Vector2(randi_range(- _boundaries.x, _boundaries.x), randi_range(-_boundaries.y, _boundaries.y))
		
			temp_positions.append(rand_pos)
				
			keycap.position = rand_pos
			
			keycaps_in_workshop.append(keycap)


func instantiate_dragging_keycap(letter):
	var kc = instantiate_keycap(letter)
	
	kc.z_index = 20

	var overlap_distance = kc.get_node("CollisionShape2D").shape.size.x * 2
	var rand_pos = Vector2(randi_range(- _boundaries.x, _boundaries.x), randi_range(-_boundaries.y, _boundaries.y))
	while _is_overlapping(rand_pos, overlap_distance):
		rand_pos = Vector2(randi_range(- _boundaries.x, _boundaries.x), randi_range(-_boundaries.y, _boundaries.y))

	temp_positions.append(rand_pos)
	kc._starting_pos_on_workshop = rand_pos
	

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		kc.position = get_global_mouse_position()
		kc._is_dragging = true
	else:
		kc.position = drop_area.get_local_mouse_position()
		kc.return_to_workshop_position()
	print(kc.position)



func instantiate_keycap(letter: String) -> Node2D:
	var keycap = _draggable_keycap.instantiate() as Node2D
	drop_area.add_child(keycap)
	keycap.setup(letter)
	return keycap


func _is_overlapping(rand_pos: Vector2, distance: float) -> bool:
	for pos in temp_positions:
		if pos.distance_to(rand_pos) < distance:
			return true
	return false


func start_nudge_anim():
	if StateMachine.current_state == StateMachine.GameState.TRANSITION_FROM_WORKSHOP:
		return
	
	anim.play("keycap_nudge_on_open_drawer")

	var tween = get_tree().create_tween()
	for keycap in keycaps_in_workshop:
		var rand_rot = randi_range(-rand_rot_amount, rand_rot_amount)
		tween.parallel().tween_property(keycap, "rotation", deg_to_rad(rand_rot), 0.2).set_ease(Tween.EASE_OUT)
