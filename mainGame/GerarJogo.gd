extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var numero = preload("./Numeros.tscn")
var gerarNumero = 0
var mainArea
var num

# Called when the node enters the scene tree for the first time.
func _ready():	
	mainArea = get_node("AreaNumeros")
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
