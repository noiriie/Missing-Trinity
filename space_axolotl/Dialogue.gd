extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_text("EXAMPLE TEXT")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

func set_text(text):
	$MarginContainer/VBoxContainer/HBoxContainer/Panel/MarginContainer/HBoxContainer/Label.text = text
