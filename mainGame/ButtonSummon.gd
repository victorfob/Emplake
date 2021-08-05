extends Node2D


var checaMouse = 1
var operacao = preload("res://mainGame/Operacao.tscn")
export (String) var nome = "+"
export (Texture) var imagem
export var complexidade = 0

#export var Imagem = preload("res://pixil-frame-2.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	if Load.dif < complexidade:
		visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ButtonSummon_pressed():
	if checaMouse == 1:
		checaMouse = 0
		var operacaoInst = operacao.instance()
		operacaoInst.nome = nome
		operacaoInst.set("_press", true)
		operacaoInst.get_node("TouchScreenButton").set_texture(imagem)
		operacaoInst.global_position = get_node("Position2D").get_global_position()
		get_node("../").add_child(operacaoInst)


func _on_ButtonSummon_released():
	checaMouse = 1
