extends Panel


var modo
var num
var formatNum = "%d%d%d%d"
var numUser
var dif
var descricao


func _ready():
	randomize()
	Load.pause = false
	numUser = get_parent().get_node("NumeroEcolha/NumBG/Numeros")
	modo = Load.modo
	dif = Load.dificuldade.Facil
	descricao = get_parent().get_node("Descricao/BG2/Descricao")
	pass


func _on_BG_botao_gui_input(event):
	if event is InputEventScreenTouch:
		var valido = 0
		if modo == 0:
			num = formatNum % [randi() % 10,randi() % 10,randi() % 10,randi() % 10]
			Load.numeros = num
			valido = 1
		elif modo == 1:
			if numUser.current_text.length() == 4:
				Load.numeros = numUser.current_text
				valido = 1
			else:
				get_parent().get_node("NumeroEcolha/NumBG/Erro").visible = true
				numUser.grab_focus()
				valido = 0
		Load.dif = dif
		if valido == 1:
			if event is InputEventScreenTouch:
				Load.modo = modo
				get_tree().change_scene("res://mainGame/mainScreem.tscn")


func _on_Facil_pressed():
	descricao.text = "Apenas os sinais primarios +, -, *, /, fatoria, raiz e parenteses";
	dif = Load.dificuldade.Facil


func _on_Medio_pressed():
	descricao.text = "Mais sinais";
	dif = Load.dificuldade.Medio


func _on_Dificil_pressed():
	descricao.text = "Mais mais sinais";
	dif = Load.dificuldade.Dificil
