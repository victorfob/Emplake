extends Node2D


# Declare member variables here. Examples:
# var a = 2
class valoresEquacao:
	var patch: Node2D
	var nome: String
	var x: float

var equacao = []
var total = 0
var mudou = 0
export (int) var deslocamento = 60
 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mudou == 1:
		var i = 0
		while i < equacao.size():
			if((total-1) %2 == 0):
				equacao[i].x = global_position.x + (deslocamento *(i - (total-1)/2))
			else:
				equacao[i].x = (global_position.x - deslocamento/2) + (deslocamento *(i - (total-1)/2))
			equacao[i].patch.change_position(equacao[i].x)
			i += 1
		mudou = 0

func novoElem(node):
	var posi = total
	equacao.append(valoresEquacao.new())
	equacao[total].patch = node
	equacao[total].patch.setPosiEqua(total)
	equacao[total].nome = node.nome
	var i = 0
	var xPosi = node.get_global_position().x
	while i < equacao.size():
		if  xPosi < equacao[i].x:
			posi = i
			var j = total
			reposicionamento(posi, j)
			break
		i += 1
	mudou = 1
	total += 1

func novaPosiElem(node):
	var xPosi = node.get_global_position().x
	var i = 0
	var inicio
	var fim
	if xPosi < equacao[node.posicaoEqua].x:
		while i < equacao.size():
			if  xPosi < equacao[i].x:
				inicio = i
				fim = node.posicaoEqua
				reposicionamento(inicio, fim)
				break
			i += 1
	else:
		i = total-1
		while i >= 0:
			if  xPosi > equacao[i].x:
				inicio = i
				fim = node.posicaoEqua
				reposicionamento(inicio, fim)
				break
			i -= 1
	mudou = 1

func removeElem(node):
	var i = 0
	while i < equacao.size():
		if(equacao[i].patch == node):
			while i+1 < equacao.size():
				equacao[i] = equacao[i+1]
				i += 1
		i += 1
	equacao.remove(total)
	total -= 1
	equacao.resize(total)
	mudou = 1
	node.free()


func reposicionamento(var inicio, var final):
	var i = inicio
	var j = final
	var direcao
	if inicio < final:
		direcao = -1
	else:
		direcao = 1
	while j != i:
		var temp = valoresEquacao.new()
		temp = equacao[j]
		equacao[j] = equacao[j+direcao]
		equacao[j+direcao] = temp
		
		equacao[j].patch.setPosiEqua(j)
		equacao[j + direcao].patch.setPosiEqua(j + direcao)
		
		j += direcao

func limpar():
	var i = total-1
	while i >= 0:
		equacao[i].patch.free()
		equacao.remove(i)
		equacao.resize(i)
		i-= 1
	total = 0
	return true

