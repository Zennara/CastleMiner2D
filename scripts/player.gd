extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 15
const SPEED = 75
const JUMP_HEIGHT = -200
var motion = Vector2()

var mp

func _physics_process(delta):
	motion.y += GRAVITY
	
	mp = get_local_mouse_position()
	
	if Input.is_action_pressed("right"):
		motion.x = SPEED
		$Body.play("Run")
		$Arms.play("run")
		$Body.flip_h = false
		$Head.flip_h = false
		$Arms.flip_h = false
	elif Input.is_action_pressed("left"):
		motion.x = -SPEED
		$Body.play("Run")
		$Arms.play("run")
		$Body.flip_h = true
		$Head.flip_h = true
		$Arms.flip_h = true
	else:
		motion.x = 0
		$Body.play("Idle")
		$Arms.play("idle")
	
	if (Input.is_action_pressed("use")):
		$Head.rotation = mp.angle()
		$Arms.rotation = mp.angle()
		if (mp.angle() < -1.5 or mp.angle() > 1.5):
			$Head.flip_h = true
			$Body.flip_h = true
			$Head.rotation = $Head.rotation + 3
			$Head.position.x = 2.5
			
			$Arms.rotation = $Arms.rotation + 3
			$Arms.flip_h = true
			$Arms.position.x = 5
			$Arms.offset.x = -3
		else:
			$Head.flip_h = false
			$Body.flip_h = false
			$Head.position.x = 1.5
			
			$Arms.flip_h = false
			$Arms.position.x = -1
			$Arms.offset.x = 3
	else:
		$Head.rotation = 0
		$Arms.rotation = 0
		
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = JUMP_HEIGHT
	
	motion = 	move_and_slide(motion, UP)
