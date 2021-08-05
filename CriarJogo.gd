extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var loadScript
var modo
var num
var formatNum = "%d%d%d%d%d%d"
var numUser
var dif
# Called when the node enters the scene tree for the first time.

func _ready():
	randomize()
	numUser = get_parent().get_node("Modo/Numeros")
	modo = 0
	dif = Load.dificuldade.Facil
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BG_botao_gui_input(event):
	var valido = 0
	if event is InputEventScreenTouch:
		if modo == 0:
			num = formatNum % [randi() % 10,randi() % 10,randi() % 10,randi() % 10,randi() % 10,randi() % 10]
			Load.numeros = num
			valido = 1
		elif modo == 1:
			if numUser.current_text.length() == 4:
				Load.numeros = numUser.current_text
				valido = 1
			else:
				get_parent().get_node("Modo/Erro").visible = true
				numUser.grab_focus()
				valido = 0
		Load.dif = dif
		if valido == 1:
			get_tree().change_scene("res://mainGame/mainScreem.tscn")


func _on_Aleatorio_pressed():
	get_parent().get_node("Modo/Erro").visible = false
	modo = 0


func _on_Especifico_pressed():
	modo = 1


func _on_Facil_pressed():
	dif = Load.dificuldade.Facil


func _on_Medio_pressed():
	dif = Load.dificuldade.Medio


func _on_Dificil_pressed():
	dif = Load.dificuldade.Dificil
