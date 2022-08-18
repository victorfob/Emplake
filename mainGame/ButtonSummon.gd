extends Node2D


var checaMouse = 1
var operacao = preload("res://mainGame/Operacao.tscn")
export (String) var nome = "+"
export (Texture) var imagem
export var complexidade = 0
export var idOperacao = 0
export var disponivel = -1
export var criados = 0

#export var Imagem = preload("res://pixil-frame-2.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true
	if Load.modo == 2 or Load.modo == 3:
		if Load.operacoes[idOperacao] != 1:
			visible = false
	elif Load.modo == 4:
		if nome != "=":
			get_node("ComprarPeca").visible = true
			if disponivel == 0:
				self.self_modulate = Color("c0c0c0")
			elif disponivel != -1:
				get_node("ComprarPeca").visible = true
			else:
				get_node("ComprarPeca").visible = false
	elif Load.dif < complexidade:
		visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ButtonSummon_pressed():
	if checaMouse == 1 and Load.pause == false:
		if Load.modo == 4:
			if disponivel == -1 or criados < disponivel:
				checaMouse = 0
				var operacaoInst = operacao.instance()
				operacaoInst.nome = nome
				operacaoInst.pathCriador = self
				operacaoInst.set("_press", true)
				operacaoInst.get_node("TouchScreenButton").set_texture(imagem)
				operacaoInst.global_position = get_node("Position2D").get_global_position()
				get_node("../").add_child(operacaoInst)
		else:
			checaMouse = 0
			var operacaoInst = operacao.instance()
			operacaoInst.nome = nome
			operacaoInst.pathCriador = self
			operacaoInst.set("_press", true)
			operacaoInst.get_node("TouchScreenButton").set_texture(imagem)
			operacaoInst.global_position = get_node("Position2D").get_global_position()
			get_node("../").add_child(operacaoInst)


func _on_ButtonSummon_released():
	checaMouse = 1

func _on_comprar_released():
	if disponivel != -1:
		self.self_modulate = Color("ffffff")
		disponivel += 1;

func proximoNivel():
	if disponivel != -1:
		disponivel -= criados
		if disponivel == 0:
			self.self_modulate = Color("ffffff")

func addNovoEle():
	if Load.modo == 4:
		if disponivel != -1:
			criados += 1
			if criados >= disponivel:
				self.self_modulate = Color("c0c0c0")

func removeEle():
	if Load.modo == 4:
		if disponivel != -1:
			criados -= 1
			if criados < disponivel:
				self.self_modulate = Color("ffffff")

