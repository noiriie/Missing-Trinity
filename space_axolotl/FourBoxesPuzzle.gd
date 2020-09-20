extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buttons_pressed = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	buttons_pressed = 0 # Replace with function body.
	$Platform.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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
