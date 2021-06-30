extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func setMessage():
	$PressMessage.text = "Bem vindo!"
	$Title.text = str(randi() % 9000 + 1000)
