extends TouchScreenButton


var mainArea
var resultadoVitoria
var resultadoErro 

# gets timer node
onready var timer = get_parent().get_node("HUD/TimerHud/Timer")
onready var file = 'res://Desafios.txt'

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
			if score < 0:
				resultadoVitoria.get_node("ValorPontuacao").text = "0 devido ao tempo"
			else:
				resultadoVitoria.get_node("ValorPontuacao").text = String(score+1)
			if Load.modo == 0 or Load.modo == 4:
				get_parent().get_node("Operacoes/TetoA/ComprarPeca").visible = false
				get_parent().get_node("Operacoes/ChaoA/ComprarPeca").visible = false
				get_parent().get_node("Operacoes/Elevado/ComprarPeca").visible = false
				get_parent().get_node("Operacoes/Fatorial/ComprarPeca").visible = false
				get_parent().get_node("Operacoes/ModuloA/ComprarPeca").visible = false
				get_parent().get_node("Operacoes/Raiz/ComprarPeca").visible = false
				get_parent().get_node("Operacoes/RaizCub/ComprarPeca").visible = false
				resultadoVitoria.get_node("Continuar").visible = true
			else:
				resultadoVitoria.get_node("Continuar").visible = false
			if Load.modo == 2:
				var f = File.new()
				var textoFile
				f.open(file, File.READ)
				textoFile = f.get_as_text()
				textoFile = textoFile.replace("0"+str(Load.desafioID)+"=0","0"+str(Load.desafioID)+"=1")
				print(textoFile)
				f.close()
				f.open(file, File.WRITE)
				f.store_string(textoFile)
				f.close()
				pass # Replace with function body.
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
	var aux_timer = get_tree().create_timer(10)
	# once 30 seconds have passed, resume timer
	yield(aux_timer, "timeout")
	timer.set_paused(0)
