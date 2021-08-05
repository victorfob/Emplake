extends TouchScreenButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mainArea

# Called when the node enters the scene tree for the first time.
func _ready():
	mainArea = get_parent().get_node("AreaNumeros")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Restart_pressed():
	print(mainArea.printEqua())
