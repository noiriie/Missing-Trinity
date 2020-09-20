extends Node2D

var dialogue = [
	[
		"Well, the ship doesn't look too damaged, but I have to find the crew and the missing piece of the engine."
	],
	[
		"I'm back!",
		"Have your memories come back yet?",
		"Not yet...",
		"But I found the singularity thruster!",
		"Good job, Jude. Let’s hook it up."
	]
]

var faces = [
	["Jude0"],
	["Jude1", "Eva1", "Jude2", "Jude1", "Noah1"]
]

var dialogue_section = 0
var dialogue_index = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.immobile = true
	$Dialogue.set_visible(true)
	dialogue_index = 0
	if not Global.has_thruster:
		dialogue_section = 0
		$Dialogue.set_text(dialogue[0][0])
		$Dialogue.set_face(faces[0][0])
	else:
		dialogue_section = 1
		$Dialogue.set_text(dialogue[1][0])
		$Dialogue.set_face(faces[1][0])
		$SceneChangeBox.target_scene = ""
		$SceneChangeBox2.target_scene = "ShipInterior"
	


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
