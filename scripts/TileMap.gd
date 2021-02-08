extends TileMap

var posx
var posy
var cellx
var celly

func _ready():
	pass

func _process(delta):
	posx = get_global_mouse_position().x
	posy = get_global_mouse_position().y
	cellx = int(get_global_mouse_position().x / get_cell_size().x)
	celly = int(get_global_mouse_position().y / get_cell_size().y)
	
	if Input.is_action_pressed("use"):
		set_cell(cellx,celly,-1)
