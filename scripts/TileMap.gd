extends TileMap

var posx
var posy
var cellx
var celly

var duration = 0
var BREAK_TIME = 1
var breakable = true
var tile
var tile_pos
var mouse_pos
var old_tile
var castcords
var castcords2
onready var player = get_node("../Player")
onready var playerbody = get_node("../Player/Body")
onready var drop = load("res://scenes/ItemDrop.tscn")


func _ready():
	pass
	
func _draw():
	draw_line(Vector2(player.position.x, player.position.y - 12), get_local_mouse_position(), Color.red)
	draw_line(Vector2(player.position.x, player.position.y + 12), get_local_mouse_position(), Color.red)
	
func raycast(cords):
	#raycast
	var ray = get_world_2d().direct_space_state.intersect_ray(Vector2(player.position.x, player.position.y-12), get_global_mouse_position(), [player])
	var ray2 = get_world_2d().direct_space_state.intersect_ray(Vector2(player.position.x, player.position.y+12), get_global_mouse_position(), [player])
	castcords = null
	castcords2 = null
	if ray.get("collider") != null:
		castcords = world_to_map(ray.position - ray.normal)
	if ray2.get("collider") != null:
		castcords2 = world_to_map(ray2.position - ray2.normal)
	if ray2.get("collider") != null || ray.get("collider") != null:
		return cords != castcords && cords != castcords2
	print(cords)
	print(castcords)
	print(castcords2)

func _physics_process(delta):
	update()
	mouse_pos = get_local_mouse_position()
	old_tile = tile_pos
	tile_pos = world_to_map(mouse_pos)
	print(get_cellv(tile_pos))
	
	cellx = int(mouse_pos.x / get_cell_size().x)
	celly = int(mouse_pos.y / get_cell_size().y)
	
	$Breaking.position = (mouse_pos - Vector2(8,8)).snapped(Vector2(16,16))

	#check if another tile is selected
	breakable = true
	if tile_pos != old_tile:
		$Breaking.frame = 0
		duration = 0
	match get_cellv(tile_pos):
		-1:
			breakable = false
			$Breaking.frame = 0
		0:
			pass
		1:
			pass

	#check if raycast collides is not selected tile
	if raycast(tile_pos):
		breakable = false

	#check distance of tile
	if mouse_pos.distance_to(player.position) > 60:
		breakable = false

	#break block
	if Input.is_action_pressed("use") and breakable == true:
		duration += delta
		#DEBUG print(duration)
		
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
		
		#break block
		if duration >= BREAK_TIME:
			set_cell(cellx, celly, -1)
			var blockDrop = drop.instance()
			blockDrop.position = mouse_pos
			#TODO: make the file names for the block textures the same as the tilset ID's. This way,
			#you can interupt the string to set the texture based on the tile ID which will also be the file name,
			#then create the pickup for said item.
			blockDrop.get_node("Sprite").texture = load("res://assets/items/Bloodstone Axe.png")
			get_parent().add_child(blockDrop)
			duration = 0

	if Input.is_action_just_released("use"):
		duration = 0
		$Breaking.frame = 0
