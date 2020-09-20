extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.frame = 1
	add_to_group("interactable")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func interact():
	print("trying to talk with Noah")
