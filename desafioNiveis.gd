extends Panel

export var numero = "0000"
#mais/menos/divisao/vezes/potencia/raizQ/fatorial/parenteses/
#mod/tetoEchao/raizC
export var opNivel = [1,0,0,0,0,0,0,0,0,0,0]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_1_gui_input(event):
	if event is InputEventScreenTouch:
		Load.modo = 2
		#Load.tutorialNum = numTutorial
		Load.desafioID = self.get_node("Label").text
		Load.operacoes = opNivel
		Load.numeros = numero
		get_tree().change_scene("res://mainGame/mainScreem.tscn")
