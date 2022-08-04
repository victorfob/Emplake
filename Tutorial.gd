extends ColorRect

var telas = []
var anterior
var proximo
var numeroTutorial = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	telas.insert(0,get_node("Tutorial controles 1"))
	telas.insert(1,get_node("Tutorial controles 2"))
	telas.insert(2,get_node("Tutorial controles 3"))
	telas.insert(3,get_node("Nivel 11"))
	telas.insert(4,get_node("Nivel 12"))
	telas.insert(5,get_node("Nivel 13"))
	telas.insert(6,get_node("Nivel 21"))
	telas.insert(7,get_node("Nivel 22"))
	telas.insert(8,get_node("Nivel 23"))
	telas.insert(9,get_node("Nivel 31"))
	telas.insert(10,get_node("Nivel 32"))
	telas.insert(11,get_node("Nivel 33"))
	anterior = get_node("Anterior")
	proximo = get_node("Proximo")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func mostrarTutorial(var numeroTela):
	telas[numeroTutorial].visible = false
	telas[numeroTela].visible = true
	numeroTutorial = numeroTela
	proximo.visible = false
	if numeroTela == 0:
		anterior.visible = false;
	else:
		anterior.visible = true;

func _on_Proximo_released():
	numeroTutorial = numeroTutorial + 1;
	if numeroTutorial == Load.tutorialNum and Load.modo == 3:
		proximo.visible = false
	if numeroTutorial == 11:
		proximo.visible = false;
	telas[numeroTutorial - 1].visible = false;
	telas[numeroTutorial].visible = true;
	anterior.visible = true;

	


func _on_Anterior_released():
	if numeroTutorial == 1:
		anterior.visible = false;
	telas[numeroTutorial].visible = false;
	telas[numeroTutorial - 1].visible = true;
	proximo.visible = true;
	numeroTutorial = numeroTutorial - 1;


func _on_Fechar_released():
	self.visible = false
	pass # Replace with function body.
