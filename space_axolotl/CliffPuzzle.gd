extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buttons_pressed = 0

var dialogue = [
	[
		"Hmm… Where could that missing thruster be?"
	],
	[
		"Here it is! The singularity thruster. Now I have to get back to the ship."
	]
]

var dialogue_section = 0
var dialogue_index = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	buttons_pressed = 0 # Replace with function body.
	$Arch.visible = false
	$Thruster.visible = true
	$SceneChangeBox.collision_layer = 0
	$SceneChangeBox.collision_mask = 0
	dialogue_index = 0
	$Player.immobile = true
	$Dialogue.set_visible(true)
	$Dialogue.set_text(dialogue[0][0])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dialogue_index < len(dialogue[dialogue_section]):
		$Dialogue.set_text(dialogue[dialogue_section][dialogue_index])
	if Input.is_action_just_pressed("ui_accept"):
		dialogue_index += 1
		if dialogue_index >= len(dialogue[dialogue_section]):
			$Player.immobile = false
			$Dialogue.set_visible(false)

func update_platform():
	if buttons_pressed == 2:
		$Arch.visible = true
		$SceneChangeBox.collision_layer = 2
		$SceneChangeBox.collision_mask = 2


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


func _on_Thruster_body_entered(body):
	if body.name == "Player":
		$Thruster.visible = false


func _on_Dialogue2_body_entered(body):
	if body.name != "Player" or dialogue_section != 0:
		return
	dialogue_index = 0
	dialogue_section = 1
	$Player.immobile = true
	$Dialogue.set_visible(true)
	pass # Replace with function body.
