extends Node2D


var numero = preload("./Numeros.tscn")
var gerarNumero = 0
var mainArea
var num

func _ready():
	mainArea = get_node("AreaNumeros")
	gerar_numeros();
	if Load.modo == 3:
		get_node("TutorialLayer/Tutorial").visible = true
		get_node("TutorialLayer/Tutorial").mostrarTutorial(Load.tutorialNum)
	if Load.modo == 4:
		mostrarPreco()

func gerar_numeros():
	mainArea.limparTudo();
	gerarNumero = 0
	var i = 0
	
	while i < 4:
		num = int(Load.numeros[i])
		var numeroIns = numero.instance()
		match num:
			0:
				numeroIns.nome = "0"
				numeroIns.get_node("Numero_Sprite").set_texture(preload("res://assets/imgs/zero.png"))
			1:
				numeroIns.nome = "1"
				numeroIns.get_node("Numero_Sprite").set_texture(preload("res://assets/imgs/um.png"))
			2:
				numeroIns.nome = "2"
				numeroIns.get_node("Numero_Sprite").set_texture(preload("res://assets/imgs/dois.png"))
			3:
				numeroIns.nome = "3"
				numeroIns.get_node("Numero_Sprite").set_texture(preload("res://assets/imgs/tres.png"))
			4:
				numeroIns.nome = "4"
				numeroIns.get_node("Numero_Sprite").set_texture(preload("res://assets/imgs/quatro.png"))
			5:
				numeroIns.nome = "5"
				numeroIns.get_node("Numero_Sprite").set_texture(preload("res://assets/imgs/cinco.png"))
			6:
				numeroIns.nome = "6"
				numeroIns.get_node("Numero_Sprite").set_texture(preload("res://assets/imgs/seis.png"))
			7:
				numeroIns.nome = "7"
				numeroIns.get_node("Numero_Sprite").set_texture(preload("res://assets/imgs/sete.png"))
			8:
				numeroIns.nome = "8"
				numeroIns.get_node("Numero_Sprite").set_texture(preload("res://assets/imgs/oito.png"))
			9:
				numeroIns.nome = "9"
				numeroIns.get_node("Numero_Sprite").set_texture(preload("res://assets/imgs/nove.png"))
		
		numeroIns.global_position = mainArea.get_global_position()
		numeroIns.global_position.x += mainArea.deslocamento*i
		numeroIns.nodeArea = mainArea
		add_child(numeroIns)
		mainArea.novoElem(numeroIns)
		i += 1

func mostrarPreco():
	get_node("Operacoes/ChaoA/ComprarPeca").visible = true
	get_node("Operacoes/ChaoB/ComprarPeca").visible = true
	get_node("Operacoes/Elevado/ComprarPeca").visible = true
	get_node("Operacoes/Fatorial/ComprarPeca").visible = true
	get_node("Operacoes/ModuloA/ComprarPeca").visible = true
	get_node("Operacoes/ModuloB/ComprarPeca").visible = true
	get_node("Operacoes/ParentA/ComprarPeca").visible = true
	get_node("Operacoes/ParentB/ComprarPeca").visible = true
	get_node("Operacoes/Raiz/ComprarPeca").visible = true
	get_node("Operacoes/TetoA/ComprarPeca").visible = true
	get_node("Operacoes/TetoB/ComprarPeca").visible = true
