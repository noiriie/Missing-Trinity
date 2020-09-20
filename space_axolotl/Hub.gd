extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var temp_state = 0

var dialogue = [
	[
		"Well, the ship doesn’t look too damaged, but I have to find the crew and the missing piece of the engine."
	]
]

var faces = [
	["Jude0"]
]

var dialogue_section = 0
var dialogue_index = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	if temp_state == 0:
		dialogue_index = 0
		$Player.immobile = true
		$Dialogue.set_visible(true)
		$Dialogue.set_text(dialogue[0][0])
		$Dialogue.set_face(faces[0][0])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dialogue_index < len(dialogue[dialogue_section]):
		$Dialogue.set_text(dialogue[dialogue_section][dialogue_index])
		$Dialogue.set_face(faces[dialogue_section][dialogue_index])
	if Input.is_action_just_pressed("ui_accept"):
		dialogue_index += 1
		if dialogue_index >= len(dialogue[dialogue_section]):
			$Player.immobile = false
			$Dialogue.set_visible(false)
