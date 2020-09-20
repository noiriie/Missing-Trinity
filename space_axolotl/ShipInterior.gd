extends Node2D

var dialogue = [
	[
		"The spaceship crashed. The last thing I remember is launching from this alien planet. Apparently, we never made it into space.",
		"I must have hit my head during the crash. I can’t recall what happened.",
		"Looks like the engine is missing the singularity thruster. We need that to fly the ship back to Earth.\nI have to find the rest of the crew and repair the ship."
	],
	[
		"I can’t remember anything about how we crashed. At least these little creatures are okay."
	],
	[
		"I need to repair the engine. Good thing I wasn't injured in the crash.\nIf it wasn't for me, we wouldn't be able to fix the ship. I'm the only one who knows how the singularity thruster works.",
		"I'm the only one who knows how the singularity thruster works...",
		"This wasn't an engine malfunction. This was sabotage. I sabotaged the engine.",
		"I... remember. We’re bringing the celestial axolotls back to Earth to be dissected.\nThey don't deserve that... I damaged the engine to crash the ship.",
		"I was going to free the axolotls, but now that Captain Noah and Dr. Eva are back, I don't have a chance.",
		"Should I repair the ship and bring the axolotls back to Earth to be dissected?\nOr should I destroy the ship permanently, stranding us on the planet forever?"
	]
]

var faces = [
	["Jude3", "Jude2", "Jude0"],
	["Jude1"],
	["Jude0", "Jude0", "Jude2", "Jude3", "Jude0", "Jude0"]
]

var dialogue_section = 0
var dialogue_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Axolotls.play("default")
	$SaveAxolotls.visible = false
	if not Global.has_thruster:
		dialogue_index = 0
		$Player.immobile = true
		$Dialogue.set_visible(true)
		$Dialogue.set_text(dialogue[0][0])
		$Dialogue.set_face(faces[0][0])
	else:
		dialogue_section = 2
		dialogue_index = 0
		$Player.immobile = true
		$Dialogue.set_visible(true)
		$Dialogue.set_text(dialogue[2][0])
		$Dialogue.set_face(faces[2][0])
		$SceneChangeBox.target_scene = "StayEnd1a"
		$SceneChangeBox2.target_scene = "LeaveEnd1a"


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
			if dialogue_section == 2:
				$SaveAxolotls.visible = true


func _on_AxolotlTrigger_body_entered(body):
	if body.name != "Player" or dialogue_section != 0 or Global.has_thruster:
		return
	dialogue_index = 0
	dialogue_section = 1
	$Player.immobile = true
	$Dialogue.set_visible(true)
