extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var temp_state = 0

var dialogue = [
	[
		"The spaceship crashed. The last thing I remember is launching from this alien planet. Apparently, we never made it into space.",
		"I must have hit my head during the crash. I can’t recall what happened.",
		"Looks like the engine is missing the singularity thruster. We need that to fly the ship back to Earth.\nI have to find the rest of the crew and repair the ship."
	],
	[
		"I can’t remember anything about how we crashed. At least these little creatures are okay."
	]
]

var faces = [
	["Jude3", "Jude2", "Jude0"],
	["Jude1"]
]

var dialogue_section = 0
var dialogue_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Axolotls.play("default")
	if temp_state == 0:
		$ShipNoah.visible = false
		$ShipEva.visible = false
		
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
			
			if dialogue_section == 1:
				# move to the next scene
				get_tree().change_scene("res://Hub.tscn")


func _on_AxolotlTrigger_body_entered(body):
	if body.name != "Player" or dialogue_section != 0 or temp_state != 0:
		return
	dialogue_index = 0
	dialogue_section = 1
	$Player.immobile = true
	$Dialogue.set_visible(true)
