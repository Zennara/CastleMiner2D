extends TileMap

var posx
var posy
var cellx
var celly

var duration = 0
var BREAK_TIME = 1
var tile

func _ready():
	pass

func _physics_process(delta):
	cellx = int(get_global_mouse_position().x / get_cell_size().x)
	celly = int(get_global_mouse_position().y / get_cell_size().y)
	
	$Breaking.position = (get_global_mouse_position() - Vector2(8,8)).snapped(Vector2(16,16))
	
	if Input.is_action_pressed("use"):
		duration += delta
		print(duration)
		
		
		if duration > 5/6.0 * BREAK_TIME:
			$Breaking.frame = 6
		elif duration > 4/6.0 * BREAK_TIME:
			$Breaking.frame = 5
		elif duration > 3/6.0 * BREAK_TIME:
			$Breaking.frame = 4
		elif duration > 2/6.0 * BREAK_TIME:
			$Breaking.frame = 3
		elif duration > 1/6.0 * BREAK_TIME:
			$Breaking.frame = 2
		elif duration < 1/6.0 * BREAK_TIME:
			$Breaking.frame = 1
		else:
			$Breaking.frame = 0
		
		if duration >= BREAK_TIME:
			set_cell(cellx, celly, 1)
			duration = 0

	if Input.is_action_just_released("use"):
		duration = 0
		$Breaking.frame = 0
