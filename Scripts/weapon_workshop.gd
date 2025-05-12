extends Area2D

const Z_INDEX_ON_DRAG = 10

var _letter
var _is_dragging = false
var _touch_position = Vector2.ZERO
var _can_drop := false
var _starting_pos_on_workshop: Vector2


func setup(letter):
	_letter = letter
	name = "keycap_" + _letter.to_lower()
	_set_sprite()


func _set_sprite():
	var texture = load("res://Sprites/Spritesheets Letters Disabled/" + _letter.to_upper() + ".png")
	var sprite = $Sprite2D as Sprite2D
	sprite.texture = texture 
	sprite.set_hframes(3)
	self.set_scale(Vector2i(3, 3))


func _input(event):
	if not _is_dragging:
		return
	
	if event.is_action_released("mouse_left"): # Drop
		_is_dragging = false
		WorkshopManager.dropping_keycap(self)
		
		if WorkshopManager.get_hovering_key():
			var key = WorkshopManager.get_hovering_key() as KeyScene
			if not key.weapon.name == "BaseWeapon":
				WorkshopManager.add_letter_in_workshop(key.weapon.weapon_letter)
				WorkshopManager.instantiate_dragging_keycap(key.weapon.weapon_letter)
				
			key.add_letter_weapon(_letter)
			queue_free()
		else:
			return_to_workshop_position()
			WorkshopManager.add_letter_in_workshop(_letter)
			z_index = 0 # Hack: check if hovering on table (over bench)
			
	if event is InputEventMouseMotion: # Dragging
		global_position = get_global_mouse_position()


func return_to_workshop_position():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", _starting_pos_on_workshop, 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	

func _on_input_event(viewport, event, shape_idx):
	#TODO: Handle overlapping keycaps
	if event.is_action_pressed("mouse_left"):
		_is_dragging = true
		_starting_pos_on_workshop = position
		
		WorkshopManager.dragging_keycap(self)
		WorkshopManager.remove_letter_in_workshop(_letter)
		
		_touch_position = event.position
		z_index = Z_INDEX_ON_DRAG
