extends CanvasLayer

var facil1
var medio1
var dificil1
var anterior
var proximo
var texto
onready var file = 'res://Desafios.txt'

# Called when the node enters the scene tree for the first time.
func _ready():
	facil1 = get_node("Niveis/Facil 1")
	medio1 = get_node("Niveis/Medio 1")
	dificil1 = get_node("Niveis/Dificil 1")
	anterior = get_node("Anterior")
	proximo = get_node("Proximo")
	texto = get_node("Label")
	
	var f = File.new()
	var textoFile
	f.open(file, File.READ)
	
	var new_style = StyleBoxFlat.new()
	new_style.set_bg_color(Color("#36a9ae"))
	new_style.set_corner_radius(CORNER_BOTTOM_LEFT,10)
	new_style.set_corner_radius(CORNER_BOTTOM_RIGHT,10)
	new_style.set_corner_radius(CORNER_TOP_LEFT,10)
	new_style.set_corner_radius(CORNER_TOP_RIGHT,10)
	var nivel
	
	var num = 1
	while not f.eof_reached():
		textoFile = f.get_line()
		if textoFile == ("0"+str(num)+"=1") or textoFile == ("00"+str(num)+"=1"):
			if num < 16:
				nivel = get_node("Niveis/Facil 1/"+str(num))
				nivel.set('custom_styles/panel', new_style)
			elif num < 31:
				nivel = get_node("Niveis/Medio 1/"+str(num-15))
				nivel.set('custom_styles/panel', new_style)
			else:
				nivel = get_node("Niveis/Dificil 1/"+str(num-30))
				nivel.set('custom_styles/panel', new_style)
		num = 1 + num
	f.close()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Proximo_released():
	if facil1.visible == true:
		facil1.visible = false
		medio1.visible = true
		anterior.visible = true
		texto.text = "Médio"
	elif medio1.visible == true:
		medio1.visible = false
		dificil1.visible = true
		proximo.visible = false
		texto.text = "Difícil"
	else:
		texto.text = "Fácil"


func _on_Anterior_released():
	if medio1.visible == true:
		facil1.visible = true
		medio1.visible = false
		anterior.visible = false
		texto.text = "Fácil"
	elif dificil1.visible == true:
		medio1.visible = true
		dificil1.visible = false
		proximo.visible = true
		texto.text = "Médio"
	else:
		texto.text = "Difícil"
