extends KinematicBody2D

const UP = Vector2(0, -1)
export var gravity = 20
const ACCELERATION = 50
export var speed = 400
export var jump_height = -550
export var inertia = 100

signal dead

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
	
	motion = move_and_slide(motion, UP, false, 4, PI/4, false)
	# set infinite inertia to false ^
	
	# process multiple collisions
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("bodies"):
			collision.collider.apply_central_impulse(-collision.normal * inertia)


func _on_PlayerHitbox_body_entered(body):
	if body.name == "Traps":
		emit_signal("dead")
	


func _on_PlayerHitbox_area_entered(area):
	if area.name == "SceneChangeBox":
		print(area.target_scene)
