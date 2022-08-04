extends ColorRect

export var numTutorial = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_1_gui_input(event):
	if event is InputEventScreenTouch:
		Load.modo = 3
		Load.tutorialNum = numTutorial
		Load.operacoes = Load.operacoesTutorial[numTutorial]
		Load.numeros = Load.numerosTutorial[numTutorial]
		get_tree().change_scene("res://mainGame/mainScreem.tscn")
