extends Node2D

signal pressed
signal released


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pressed = false
export var required_name = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var count = 0
	for body in $PlayerInteractBox.get_overlapping_bodies():
		if body.is_in_group("pushes_buttons") and (required_name == "" or body.name == required_name):
			count = count + 1
	
	if count > 0:
		if not pressed:
			emit_signal("pressed")
		pressed = true
	else:
		if pressed:
			emit_signal("released")
		pressed = false
