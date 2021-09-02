extends Node2D

var mainArea

func _ready():
	mainArea = get_parent().get_node("AreaNumeros")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Restart_pressed():
	if Load.pause == false:
		mainArea.limpar()
