extends Node2D


# Declare member variables here. Examples:
# var a = 2
var click = 0
var numero = preload("./Numeros.tscn")
var gerarNumero = 0
var mainArea

func _ready():
	mainArea = get_parent().get_node("AreaNumeros")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if gerarNumero == 1:
		gerarNumero = 0
		var i = 4
		
		while i > 0:
			var num = randi() % 10
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
			numeroIns.nodeArea = mainArea
			get_node("../").add_child(numeroIns)
			mainArea.novoElem(numeroIns)
			i -= 1


func _on_Restart_pressed():
	if click == 0:
		mainArea.printEqua()
		if mainArea.limpar() == true:
			gerarNumero = 1

func _on_Restart_released():
	click = 0