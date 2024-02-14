extends Label

var pos_offset

func _ready():
	pos_offset = size * 0.5

func _process(_delta):
	position = get_global_mouse_position() - pos_offset
