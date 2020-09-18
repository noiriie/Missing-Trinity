extends RigidBody2D

const UP = Vector2(0, -1)
export var gravity = 40

var motion = Vector2();

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	motion.y += gravity
	
	if motion.x > 0:
		motion.x = motion.x*0.75
