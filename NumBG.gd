extends Panel

var loadScript

# Called when the node enters the scene tree for the first time.
func _ready():
	if Load.modo == 1:
		visible = true
	else:
		visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
