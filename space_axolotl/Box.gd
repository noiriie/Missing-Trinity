extends RigidBody2D

const UP = Vector2(0, -1)
export var gravity = 300

var motion = Vector2();

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("bodies")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	motion.y += gravity
