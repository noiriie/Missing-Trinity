extends KinematicBody2D

const UP = Vector2(0, -1)
export var gravity = 20
const ACCELERATION = 50
export var speed = 400
export var jump_height = -550
export var inertia = 100
export var max_dead_time = 0.6

signal dying
signal dead

var motion = Vector2();
var dying = false
var dying_time = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	dying = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _start_dying():
	emit_signal("dying")
	dying = true
	dying_time = 0

func _physics_process(delta):
	if dying:
		# play slow falling animation
		print(motion.y)
		motion.x = 0
		motion.y /= exp(dying_time*2)
		dying_time += delta
		if dying_time >= max_dead_time:
			emit_signal("dead")
		else:
			motion = move_and_slide(motion, UP)
		return
		
	motion.y += gravity
	
	# process interacting
	if Input.is_action_just_pressed("ui_accept"):
		for body in $PlayerInteractBox.get_overlapping_bodies():
			if body == self:
				continue
			
			# TODO: do something here, pick up boxes, enter doors, etc.
	
	if Input.is_action_pressed("ui_right"):
		motion.x = speed #min(motion.x + ACCELERATION, MAX_SPEED)
		$PlayerInteractBox.set_scale(Vector2(1, 1))
	elif Input.is_action_pressed("ui_left"):
		motion.x = -speed #max(motion.x - ACCELERATION, -MAX_SPEED)
		$PlayerInteractBox.set_scale(Vector2(-1, 1))
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
		_start_dying()

func _on_PlayerHitbox_area_entered(area):
	if area.name == "SceneChangeBox":
		get_tree().change_scene("res://" + area.target_scene + ".tscn")
