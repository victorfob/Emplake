extends ColorRect

export var num = "0000"

export var mais = 0
export var menos = 0
export var mult = 0
export var divi = 0
export var pote = 0
export var raiz = 0
export var fatorial = 0
export var parente = 0
export var modulo = 0
export var tetochao = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_1_gui_input(event):
	if event is InputEventScreenTouch:
		Load.modo = 2
		Load.operacoes[0] = mais;
		Load.operacoes[1] = menos;
		Load.operacoes[2] = mult;
		Load.operacoes[3] = divi;
		Load.operacoes[4] = pote;
		Load.operacoes[5] = raiz;
		Load.operacoes[6] = fatorial;
		Load.operacoes[7] = parente;
		Load.operacoes[8] = modulo;
		Load.operacoes[9] = tetochao;
		Load.numeros = num
		get_tree().change_scene("res://mainGame/mainScreem.tscn")
