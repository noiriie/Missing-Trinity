extends KinematicBody2D

const UP = Vector2(0, -1)
export var gravity = 20
const ACCELERATION = 50
export var speed = 400
export var jump_height = -550

var motion = Vector2();


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	motion.y += gravity
	
	if Input.is_action_pressed("ui_right"):
		motion.x = speed #min(motion.x + ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed("ui_left"):
		motion.x = -speed #max(motion.x - ACCELERATION, -MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, .2)
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = jump_height
	
	motion = move_and_slide(motion, UP)
	pass