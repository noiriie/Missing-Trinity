extends KinematicBody2D

const UP = Vector2(0, -1)
export var gravity = 20
const ACCELERATION = 50
export var speed = 400
export var jump_height = -640
export var inertia = 100
export var max_dead_time = 0.6
export var pushes_buttons = true

signal dying
signal dead

var motion = Vector2();
var dying = false
var dying_time = 0
var facing = Vector2()

var holding = null


# Called when the node enters the scene tree for the first time.
func _ready():
	facing = Vector2(1, 0)
	dying = false
	holding = null
	if pushes_buttons:
		add_to_group("pushes_buttons")


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
		if holding:
			var unhold_pos = position + $PlayerInteractBox.position + 96*facing
			unhold_pos.y += -32
			holding.interact_end(unhold_pos)
			holding = null
		else:
			for body in $PlayerInteractBox.get_overlapping_bodies():
				if body == self:
					continue
				
				if body.is_in_group("interactable") and not holding:
					holding = body
					holding.interact_begin()
					break
	
	if Input.is_action_pressed("ui_right"):
		motion.x = speed #min(motion.x + ACCELERATION, MAX_SPEED)
		$AnimatedSprite.flip_h = true
		if is_on_floor():
			$AnimatedSprite.play("run")
		$PlayerInteractBox.set_scale(Vector2(1, 1))
		facing.x = 1
	elif Input.is_action_pressed("ui_left"):
		motion.x = -speed #max(motion.x - ACCELERATION, -MAX_SPEED)
		$AnimatedSprite.flip_h = false
		if is_on_floor():
			$AnimatedSprite.play("run")
		$PlayerInteractBox.set_scale(Vector2(-1, 1))
		facing.x = -1
	else:
		if is_on_floor():
			$AnimatedSprite.play("idle")
			
		motion.x = lerp(motion.x, 0, .2)
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			$AnimatedSprite.play("jump")
			motion.y = jump_height
	
	motion = move_and_slide(motion, UP, false, 4, PI/4, false)
	# set infinite inertia to false ^
	
	if motion.y > 1:
		$AnimatedSprite.play("fall")
	
	# process multiple collisions
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("bodies"):
			collision.collider.apply_central_impulse(-collision.normal * inertia)
			
	# if holding something, let it move with us
	if holding:
		holding.set_held_pos(Vector2(position.x, position.y - 64))


func _on_PlayerHitbox_body_entered(body):
	if body.name == "Traps":
		_start_dying()

func _on_PlayerHitbox_area_entered(area):
	if area.name == "SceneChangeBox":
		get_tree().change_scene("res://" + area.target_scene + ".tscn")
