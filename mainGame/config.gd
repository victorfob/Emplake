extends TouchScreenButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_config_pressed():
	
	if get_parent().get_node("MenuLayer/BackOP").visible == true:
		get_parent().get_node("MenuLayer/BackOP").visible = false
		Load.pause = false
	else:
		get_parent().get_node("MenuLayer/BackOP").visible = true
		Load.pause = true

func _on_FecharM_pressed():
	Load.pause = false
	get_parent().get_node("MenuLayer/BackOP").visible = false


func _on_VoltarMenu_pressed():
	Load.pause = false
	get_tree().change_scene("res://MainMenu.tscn")


func _on_AbrirTutorial_pressed():
	get_parent().get_node("TutorialLayer/Tutorial").visible = true
