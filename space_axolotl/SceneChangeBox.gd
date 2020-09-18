extends Area2D

export var target_scene = "Main"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SceneChangeBox_body_entered(body):
	print("test")
	if body.name == "PlayerHitbox":
		print("SCENE CHANGE")
