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
	add_to_group("bodies")
	add_to_group("interactable")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(position)
	print("test ", $CollisionShape2D.position)
	
func _integrate_forces(state):
	#print(state.transform)
	if held:
		state.transform = Transform2D(0, held_pos)
	if unheld_pos:
		#$CollisionShape2D.position = unheld_pos
		state.transform = Transform2D(0, unheld_pos)
		state.linear_velocity = Vector2(0, 1)
		#state.angular_velocity = Vector2(0, 0)
		unheld_pos = null
		
func set_held_pos(pos):
	held_pos = pos
	position = pos
	#$CollisionShape2D.position = pos
	
func interact_begin():
	held = true
	$CollisionShape2D.disabled = true
	
func interact_end(pos):
	held = false
	$CollisionShape2D.disabled = false
	update()
	position = pos
	unheld_pos = pos
