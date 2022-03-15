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



func _on_Enviar_pressed():
	if Load.pause == false:
		var resultado = get_parent().get_node("VioriaLayer/TelaVitoria")
		if mainArea.comecarPrint() == true:
			resultado.visible = true
			var result = mainArea.getFinalResult()
			var score = mainArea.getFinalScore()
			resultado.get_node("ValorVitoria").text = result
			resultado.get_node("ValorPontuacao").text = String(score)