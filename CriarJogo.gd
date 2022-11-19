extends Panel


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
		if modo == 2:
			get_tree().change_scene("res://SelecaoNiveis.tscn")
		elif modo == 3:
			get_tree().change_scene("res://ModoAprendizado.tscn")
		elif modo == 4:
			get_tree().change_scene("res://mainGame/mainScreem.tscn")
		else:
			get_tree().change_scene("res://Dificuldade.tscn")


func _on_Aleatorio_pressed():
	get_parent().get_node("Modo/Erro").visible = false
	descricao.text = "Os numeros serão escolhidos de forma aleatoria";
	modo = 0


func _on_Especifico_pressed():
	descricao.text = "Os numeros serão escolhidos pelo jogador";
	modo = 1
	

func _on_Especifico2_pressed():
	get_parent().get_node("Modo/Erro").visible = false
	descricao.text = "Conjunto de desafios com diferentes dificuldades";
	modo = 2


func _on_Educacional_pressed():
	get_parent().get_node("Modo/Erro").visible = false
	descricao.text = "Modo para aprender o funcionamento do jogo e como as operações funcionam";
	modo = 3
	pass # Replace with function body.


func _on_Aventura_pressed():
	descricao.text = "Modo sobrevivencia";
	modo = 4
	var num = "%d%d%d%d" % [randi() % 10,randi() % 10,randi() % 10,randi() % 10]
	Load.numeros = num
	pass # Replace with function body.
