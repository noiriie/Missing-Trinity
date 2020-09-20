extends Control

func _ready():
	$AudioStreamPlayer.play()


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://LeaveEnd2a.tscn")
