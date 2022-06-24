extends ColorRect


var modo
var dif
var descricao

func _ready():
	randomize()
	Load.pause = false
	modo = 0
	dif = Load.dificuldade.Facil
	descricao = get_parent().get_node("Descricao/Descricao")
	_on_Aleatorio_pressed()
	pass 


func _on_BG_botao_gui_input(event):
	var valido = 0
	if event is InputEventScreenTouch:
		Load.modo = modo
		get_tree().change_scene("res://Dificuldade.tscn")


func _on_Aleatorio_pressed():
	get_parent().get_node("Modo/Erro").visible = false
	descricao.text = "Os numeros serão escolhidos de forma aleatoria";
	modo = 0


func _on_Especifico_pressed():
	descricao.text = "Os numeros serão escolhidos pelo usuario";
	modo = 1
