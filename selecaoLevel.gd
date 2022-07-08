extends CanvasLayer

var facil1
var medio1
var dificil1
var anterior
var proximo
var texto

# Called when the node enters the scene tree for the first time.
func _ready():
	facil1 = get_node("Niveis/Facil 1")
	medio1 = get_node("Niveis/Medio 1")
	dificil1 = get_node("Niveis/Dificil 1")
	anterior = get_node("Anterior")
	proximo = get_node("Proximo")
	texto = get_node("Label")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Proximo_released():
	if facil1.visible == true:
		facil1.visible = false
		medio1.visible = true
		anterior.visible = true
		texto.text = "Médio"
	elif medio1.visible == true:
		medio1.visible = false
		dificil1.visible = true
		proximo.visible = false
		texto.text = "Difícil"
	else:
		texto.text = "Fácil"


func _on_Anterior_released():
	if medio1.visible == true:
		facil1.visible = true
		medio1.visible = false
		anterior.visible = false
		texto.text = "Fácil"
	elif dificil1.visible == true:
		medio1.visible = true
		dificil1.visible = false
		proximo.visible = true
		texto.text = "Médio"
	else:
		texto.text = "Difícil"
