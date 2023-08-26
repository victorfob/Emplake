extends TouchScreenButton


onready var timer = get_parent().get_node("HUD/TimerHud/Timer")

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
	if Load.modo == 2:
		get_tree().change_scene("res://SelecaoNiveis.tscn")
	else:
		get_tree().change_scene("res://MainMenu.tscn")

func _on_AbrirTutorial_pressed():
	get_parent().get_node("TutorialLayer/Tutorial").visible = true


func _on_Continuar_released():
	if Load.modo == 3:
		get_parent().get_node("TutorialLayer/Tutorial").visible = true
		Load.tutorialNum = Load.tutorialNum + 1
		get_parent().get_node("TutorialLayer/Tutorial").mostrarTutorial(Load.tutorialNum)
		Load.numeros = Load.numerosTutorial[Load.tutorialNum]
		Load.operacoes = Load.operacoesTutorial[Load.tutorialNum]
		get_parent().gerar_numeros()
		updateBotao()
		get_parent().get_node("VioriaLayer/TelaVitoria").visible = false
	elif Load.modo == 0:
		var num = "%d%d%d%d" % [randi() % 10,randi() % 10,randi() % 10,randi() % 10]
		Load.numeros = num
		get_parent().gerar_numeros()
		get_parent().get_node("VioriaLayer/TelaVitoria").visible = false
	elif Load.modo == 4:
		var num = "%d%d%d%d" % [randi() % 10,randi() % 10,randi() % 10,randi() % 10]
		Load.numeros = num
		get_parent().gerar_numeros()
		get_parent().get_node("VioriaLayer/TelaVitoria").visible = false
		get_parent().get_node("AreaNumeros").addScore();
		get_parent().get_node("AreaNumeros").atualizarPreco(1000)
		updateBotao()
	else:
		get_parent().get_node("VioriaLayer/TelaVitoria/Continuar").visible = false
	timer.start(30)
	timer.set_paused(0)
	pass # Replace with function body.

func updateBotao():
	get_parent().get_node("Operacoes/ChaoA")._ready()
	get_parent().get_node("Operacoes/ChaoB")._ready()
	get_parent().get_node("Operacoes/Divisao")._ready()
	get_parent().get_node("Operacoes/Elevado")._ready()
	get_parent().get_node("Operacoes/RaizCub")._ready()
	get_parent().get_node("Operacoes/Fatorial")._ready()
	get_parent().get_node("Operacoes/Igual")._ready()
	get_parent().get_node("Operacoes/Mais")._ready()
	get_parent().get_node("Operacoes/Menos")._ready()
	get_parent().get_node("Operacoes/ModuloA")._ready()
	get_parent().get_node("Operacoes/ModuloB")._ready()
	get_parent().get_node("Operacoes/ParentA")._ready()
	get_parent().get_node("Operacoes/ParentB")._ready()
	get_parent().get_node("Operacoes/Raiz")._ready()
	get_parent().get_node("Operacoes/TetoA")._ready()
	get_parent().get_node("Operacoes/TetoB")._ready()
	get_parent().get_node("Operacoes/Vezes")._ready()
