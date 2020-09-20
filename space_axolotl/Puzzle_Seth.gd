extends Node2D


var buttons_pressed = 0

var dialogue = [
	[

		"Wow! It’s cold in here. Hellooooo??",
		"[far away]: Jude, is that you? I’m over here!",
		"Dr. Eva! Don’t worry, I’ll find you."

	],
	[
		"Are the axolotls alright?",
		"The what?",
		"The celestial axolotls. They were on the ship.",
		"You mean the three creatures in the fish tank? They’re completely fine.",
		"What a relief! If anything were to happen to them before we got them back to the research \nstation on Earth… Well, you know.",
		"No, I don’t know.",
		"I told you about the axolotl research about 5 minutes before the ship crashed. Don’t you remember?",
		"I don’t remember anything about the crash. I hit my head.",
		"Oh, you poor thing! Are you okay?",
		"I think so. I have a little headache, but I’m alright.",
		"You don’t seem to be experiencing any major symptoms of head trauma. Well, expect for the \nmemory loss. Your memories should return soon.",
		"I need to go check on the axolotls. I can’t let anything happen to them before we get \nback to Earth. They need to be ready for research.",
		"Research? What kind of research?",
		"I told you before the ship crashed, and you got upset. Maybe it’s better if you don’t know.",
		". . . . .",
		"I need to get back to the axolotls.",
		"Fine. I’ll keeping searching for the singularity thruster."
	]
]

var faces = [
	["Jude0", "Eva2", "Jude3"],
	["Eva2", "Jude3", "Eva2", "Jude0", "Eva1", "Jude0", "Eva3", "Jude0", "Eva2", "Jude0", "Eva1", "Eva0", "Jude3", "Eva0", "Jude2", "Eva0", "Jude0"]
]

var dialogue_section = 0
var dialogue_index = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	buttons_pressed = 0 # Replace with function body.
	$Platform.visible = false
	dialogue_index = 0
	$Player.immobile = true
	$Dialogue.set_visible(true)
	$Dialogue.set_text(dialogue[0][0])
	$AudioStreamPlayer.play()


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

func update_platform():
	if buttons_pressed == 4:
		$Platform.visible = true
		$Platform.collision_layer = 1
	else:
		$Platform.visible = false
		$Platform.collision_layer = 0


func _on_Button_pressed():
	buttons_pressed += 1
	print(buttons_pressed, "pressed")
	update_platform()


func _on_Button_released():
	buttons_pressed -= 1
	print(buttons_pressed, "unpressed")
	update_platform()


func _on_Player_dead():
	get_tree().reload_current_scene()


func _on_DialogueTrigger_body_entered(body):
	if body.name != "Player" or dialogue_section != 0:
		return
	dialogue_index = 0
	dialogue_section = 1
	$Player.immobile = true
	$Dialogue.set_visible(true)
	$EvaIceCaves.visible = true
	$PodClosed.visible = false
	$PodOpen.visible = true


func _on_Button2_pressed():
	pass # Replace with function body.
