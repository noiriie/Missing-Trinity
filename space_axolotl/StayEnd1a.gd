extends Control


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://StayEnd2a.tscn")
