extends RigidBody2D

const UP = Vector2(0, -1)
export var gravity = 300

var motion = Vector2()
var held = false
var held_pos = Vector2()
var unheld_pos = null

# Called when the node enters the scene tree for the first time.
func _ready():
	held = false
	held_pos = position
	unheld_pos = null
	can_sleep = false
	add_to_group("bodies")
	add_to_group("interactable")
	add_to_group("pushes_buttons")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for body in $Below.get_overlapping_bodies():
		if body.is_in_group("interactable"):
			mass = 20
		else:
			mass = 5
	#print(position)
	#print("test ", $CollisionShape2D.position)
	
func _integrate_forces(state):
	#print(state.transform)
	if held:
		state.transform = Transform2D(0, held_pos)
		state.linear_velocity = Vector2(0, 0)
	if unheld_pos:
		state.set_transform(Transform2D(0, unheld_pos))
		state.linear_velocity = Vector2(0, 0)
		#state.set_angular_velocity(Vector2(0, 0))
		#state.angular_velocity = Vector2(0, 0)
		unheld_pos = null
		
func set_held_pos(pos):
	held_pos = pos
	position = pos
	
func interact_begin():
	held = true
	$CollisionShape2D.disabled = true
	
func interact_end(pos):
	held = false
	position = pos
	unheld_pos = pos
	$CollisionShape2D.disabled = false
