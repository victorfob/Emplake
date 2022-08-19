extends TouchScreenButton


var mainArea
var resultadoVitoria
var resultadoErro 

# gets timer node
onready var timer = get_parent().get_node("HUD/TimerHud/Timer")

func _ready():
	mainArea = get_parent().get_node("AreaNumeros")
	resultadoVitoria = get_parent().get_node("VioriaLayer/TelaVitoria")
	resultadoErro = get_parent().get_node("DerrotaLayer/TelaErro")

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Enviar_pressed():
	if Load.pause == false:
		if mainArea.comecarPrint() == true:
			resultadoVitoria.visible = true
			var result = mainArea.getFinalResult()
			var score = mainArea.getFinalScore()
			resultadoVitoria.get_node("ValorVitoria").text = result
			resultadoVitoria.get_node("ValorPontuacao").text = String(score)
			if Load.modo == 3 and Load.tutorialNum != 11:
				resultadoVitoria.get_node("Continuar").visible = true
			elif Load.modo == 0 or Load.modo == 4:
				resultadoVitoria.get_node("Continuar").visible = true
			else:
				resultadoVitoria.get_node("Continuar").visible = false
		else:
			resultadoErro.visible = true
			var valorMetade1 = mainArea.getValoreMetade1()
			var valorMetade2 = mainArea.getValoreMetade2()
			resultadoErro.get_node("ValorMetade1").text = String(valorMetade1)
			resultadoErro.get_node("ValorMetade2").text = String(valorMetade2)
			yield(get_tree().create_timer(1), "timeout")
			timer.set_paused(0)


func _on_VoltarMenu_pressed():
	resultadoErro.visible = false


func _on_PauseButton_pressed():
	# pauses timer
	timer.set_paused(1)
	# waits 30 secs to write answer
	var aux_timer = get_tree().create_timer(30)
	# once 30 seconds have passed, resume timer
	yield(aux_timer, "timeout")
	timer.set_paused(0)
