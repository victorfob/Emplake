extends Node2D

enum situacao {INSERINDO, NOVA_POSI, NOVO, DELET, MOVENDO, PARADO}
var situacaoAtual = situacao.NOVO
var nodeArea = null
var posicaoEqua
export (String) var nome = '+'
export (Vector3) var posiIni = Vector3(0,0,0)
var click = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("TouchScreenButton").emit_signal("pressed")
	posiIni = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if click == 1:
		if (situacaoAtual != situacao.INSERINDO 
		and situacaoAtual != situacao.NOVO
		and situacaoAtual != situacao.DELET):
			situacaoAtual = situacao.MOVENDO
			z_index = 1000
	elif  click == 0:
		match situacaoAtual:
			situacao.INSERINDO:
				situacaoAtual = situacao.PARADO
				nodeArea.novoElem(self)
			situacao.NOVA_POSI:
				situacaoAtual = situacao.PARADO
				global_position = posiIni
				z_index = 0
			situacao.MOVENDO:
				situacaoAtual = situacao.PARADO
				nodeArea.novaPosiElem(self)
			situacao.NOVO:
				self.free()
			situacao.DELET:
				if nodeArea != null:
					nodeArea.removeElem(self)

func setPosiEqua(var posi):
	posicaoEqua = posi

func change_position(x):
	posiIni.x = x
	situacaoAtual = situacao.NOVA_POSI

func _on_TouchScreenButton_pressed():
	click = 1

func _on_TouchScreenButton_released():
	click = 0

func _on_AreaOperacao_area_entered(area):
	if area.name == "ANumeros":
		posiIni = area.get_global_position()
		if situacaoAtual == situacao.NOVO:
			situacaoAtual = situacao.INSERINDO
		else:
			situacaoAtual = situacao.MOVENDO
		nodeArea = area.get_parent()


func _on_AreaOperacao_area_exited(area):
	if(area.name == "ANumeros"):
		if situacaoAtual == situacao.INSERINDO:
			situacaoAtual = situacao.NOVO
		else:
			situacaoAtual = situacao.DELET

func _input(event):
	if event is InputEventScreenDrag and click == 1:
		# While dragging, move the sprite with the mouse.
		position = event.position
	if event is InputEventScreenTouch and event.is_pressed() == false:
		click = 0
