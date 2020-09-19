extends RigidBody2D

const UP = Vector2(0, -1)
export var gravity = 300

var motion = Vector2();
var picked = false
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("bodies")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	motion.y += gravity
	if picked == true:
		self.position = get_node("Position2D").global_position
		


func _input(event):
	if Input.is_action_just_pressed("e"):
		var bodies = $Detector.get_overlapping_bodies()
		for b in bodies:
			print(b)
			if b.name == "Player" and picked == false:
				picked = true
