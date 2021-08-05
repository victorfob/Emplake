extends Node2D


# Declare member variables here. Examples:
# var a = 2
class valoresEquacao:
	var patch: Node2D
	var nome: String
	var x: float

onready var expression = Expression.new()
var equacao = []
var total = 0
var mudou = 0
var regex = RegEx.new()
export (int) var deslocamento = 60
 
# Called when the node enters the scene tree for the first time.
func _ready():
	regex.compile("^[0-9]*$")
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
	var numPosi = 4
	while i >= 0:
		if !regex.search(equacao[i].nome):
			equacao[i].patch.free()
			equacao.remove(i)
		i-= 1
	equacao.resize(4)
	total = 4
	mudou = 1
	return true

func printEqua():
	var equa = []
	var equaAnt
	var equaDps
	equa.append("")
	var parte = 0
	var numSeguido = 0
	var igual = 0
	var parent = 0
	var modulo = 0
	var fecharPow = -1
	var partes = 0
	var i = 0
	while i < total:
		match equacao[i].nome:
			"=":
				if parent > 0 or modulo == 1:
					return false
				while parte > 0:
					equa[parte - 1] = str(equa[parte-1] + equa[parte])
					parte -= 1
				equaAnt = equa[parte]
				igual = 1
				equa.resize(1)
				equa[0] = ""
			"(":
				parte += 1
				equa.append("")
				equa[parte] = ""
				equa[parte] = str(equa[parte] + equacao[i].nome)
				parent += 1
			")":
				if parent < 0:
					return false
				equa[parte] = str(equa[parte] + equacao[i].nome)
				equa[parte-1] = str(equa[parte-1] + resolve(equa[parte]))
				equa.resize(parte)
				parte -= 1
				parent -= 1
				if fecharPow == parent:
					equa[parte] = str(equa[parte] + equacao[i].nome)
					fecharPow = -1
			"|":
				if modulo == 0:
					parte += 1
					equa.append("")
					equa[parte] = ""
					modulo = 1
					parent += 1
				else:
					modulo = 0
					equa[parte] = resolve(equa[parte])
					if(int(equa[parte]) < 0):
						equa[parte] = str(int(equa[parte]) * -1)
					equa[parte - 1] = str(equa[parte-1] + equa[parte])
					equa.resize(parte)
					parte -= 1
					parent -= 1
					if parent < 0:
						return false
				if fecharPow == parent:
					equa[parte] = str(equa[parte] + ")")
			"^":
				var pow1
				var pow2 
				if regex.search(equacao[i-1].nome):
					var text = equa[parte]
					text.erase(text.length() - 1, 1)
					equa[parte] = str(text)
					pow1 = equacao[i-1].nome
				elif equacao[i-1].nome == ")":
					var text = equa[parte]
					text.erase(0, text.length())
					pow1 = equa[parte]
					equa[parte] = str(text)
				if regex.search(equacao[i+1].nome):
					pow2 = equacao[i+1].nome
					i += 1
					equa[parte] = str(equa[parte] + "pow(%s,%s)" % [pow1, pow2])
				elif equacao[i+1].nome == "(" or equacao[i+1].nome == "|":
					equa[parte] = str(equa[parte] + "pow(%s," % [pow1])
					fecharPow = parent
			_:
#				if regex.search(equacao[i].nome) and numSeguido == 1:
#					return false
#				elif regex.search(equacao[i].nome):
#					numSeguido = 1
#				else:
#					numSeguido = 0
				equa[parte] = str(equa[parte] + equacao[i].nome)
				while parent < parte:
					equa[parte - 1] = str(equa[parte-1] + equa[parte])
					equa.resize(parte)
					parte -= 1
		i += 1
	
	if igual == 0:
		return false
	if parent > 0 or modulo == 1:
		return false
	while parte > 0:
		equa[parte - 1] = str(equa[parte-1] + equa[parte])
		parte -= 1
	equaDps = equa[parte]
	
	print(equaAnt)
	print(equaDps)
	print(resolve(equaAnt))
	print(resolve(equaDps))

func resolve(command):
	var error = expression.parse(command, [])
	if error != OK:
		print(expression.get_error_text())
		return
	var result = expression.execute([], null, true)
	if not expression.has_execute_failed():
		return str(result)
