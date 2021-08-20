extends Node2D


# Declare member variables here. Examples:
# var a = 2
class valoresEquacao:
	var patch: Node2D
	var nome: String
	var x: float

var expressaoStr = []
onready var expression = Expression.new()
var equacao = []
var total = 0
var mudou = 0
var regex = RegEx.new()
export (int) var deslocamento = 60
 
# Called when the node enters the scene tree for the first time.
func _ready():
	regex.compile("^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$")
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
	if xPosi == equacao[node.posicaoEqua].x:
		return
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

func comecarPrint():
	var i = 0
	while i < total:
		expressaoStr.append("")
		expressaoStr[i] = equacao[i].nome
		i += 1
	return printEqua(0, null)

func printEqua(var inicio, var estado):
	var percorre = inicio
	var fim = expressaoStr.size()
	var expressao1 = ""
	var expressao2 = ""
	var posiIgual = 0
	var numSeguido = 0
	while percorre < expressaoStr.size():
		match expressaoStr[percorre]:
			"(", "|", "[", "{":
				
				if printEqua(percorre + 1, expressaoStr[percorre]) == false:
					print("Erro recurssão")
					return false
				
				expressaoStr.remove(percorre)
				fim = expressaoStr.size()
			
			")", "I", "]", "}":
				
				var tipo = ""
				
				if expressaoStr[percorre] == ")":
					tipo = "("
				elif expressaoStr[percorre] == "I":
					tipo = "|"
				elif expressaoStr[percorre] == "]":
					tipo = "["
				else:
					tipo = "{"
				
				if estado != tipo:
					print("Erro fechando expressao na hora errada")
					return false
					
				var expressao = ""
				
				while inicio <= percorre:
					expressao = str(str(expressaoStr[percorre])+ expressao)
					expressaoStr.remove(percorre)
					percorre -= 1
				
				var result = resolve(expressao)
				
				if result == "Erro":
					print("Erro na expressao")
					return false
				
				if tipo == "|":
					if int(result) < 0:
						result = str(float(result) * -1)
				elif tipo == "{":
					result = str(floor(float(result)))
				elif tipo == "[":
					result = str(int(ceil(float(result))))
				
				print("Resultado da fechagem da operação: %s" % [result])
				expressaoStr.insert(percorre+1, result)
				return true
			
			"^":
				
				if (expressaoStr[percorre + 1] == "(" 
				or expressaoStr[percorre + 1] == "|" 
				or expressaoStr[percorre + 1] == "[" 
				or expressaoStr[percorre + 1] == "{"):
					if printEqua(percorre + 2, expressaoStr[percorre+1]) == false:
						print("Erro na recurssão durante ^")
						return false
					
					expressaoStr.remove(percorre+1)
					fim = expressaoStr.size()
				
				var elevado = str("pow(%s,%s)" % [expressaoStr[percorre-1], expressaoStr[percorre+1]])
				var result = resolve(elevado)
				
				if result == "Erro":
					print("Erro na expressao durante ^")
					return false
				
				expressaoStr.remove(percorre+1)
				expressaoStr.remove(percorre)
				expressaoStr.remove(percorre-1)
				print("Resultado elevado: %s" % [result])
				expressaoStr.insert(percorre-1, result)
				percorre -= 1
				fim = expressaoStr.size()
				
			"/":
				
				if (expressaoStr[percorre + 1] == "(" 
				or expressaoStr[percorre + 1] == "|" 
				or expressaoStr[percorre + 1] == "[" 
				or expressaoStr[percorre + 1] == "{"):
					if printEqua(percorre + 2, expressaoStr[percorre+1]) == false:
						print("Erro na recurssão durante /")
						return false
					
					expressaoStr.remove(percorre+1)
					fim = expressaoStr.size()
				
				var divisao = str("float(%s)/" % [expressaoStr[percorre-1]])
				
				numSeguido = 0
				expressaoStr.remove(percorre)
				expressaoStr.remove(percorre-1)
				
				print("Resultado divisão: %s" % [divisao])
				expressaoStr.insert(percorre-1, divisao)
				percorre -= 1
				fim = expressaoStr.size()
			
			"R":
				
				if (expressaoStr[percorre + 1] == "(" 
				or expressaoStr[percorre + 1] == "|" 
				or expressaoStr[percorre + 1] == "[" 
				or expressaoStr[percorre + 1] == "{"):
					if printEqua(percorre + 2, expressaoStr[percorre+1]) == false:
						print("Erro na recurssão durante raiz")
						return false
					
					expressaoStr.remove(percorre+1)
					fim = expressaoStr.size()
				
				var raiz = str("sqrt(%s)" % [expressaoStr[percorre+1]])
				var result = resolve(raiz)
				
				if result == "Erro":
					print("Erro na expressao durante raiz")
					return false
				
				expressaoStr.remove(percorre+1)
				expressaoStr.remove(percorre)
				
				print("Resultado raiz: %s" % [result])
				expressaoStr.insert(percorre, result)
				percorre -= 1
				fim = expressaoStr.size()
			
			"!":
				
				if percorre <= 0:
					print("! na posicao errada")
					return false
				
				var result = fatorial(expressaoStr[percorre-1])
				
				if result == "Erro":
					print("Erro na expressao durante !")
					return false
				elif result == "Overflow":
					print("Valor muito grande no !")
					return false
				
				expressaoStr.remove(percorre)
				expressaoStr.remove(percorre-1)
				
				print("Resultado fatorial: %s" % [result])
				expressaoStr.insert(percorre-1, result)
				percorre -= 1
				fim = expressaoStr.size()
			
			"=":
				
				if posiIgual != 0:
					print("Erro mais de um igual")
					return false
				elif estado != null:
					print ("Erro na expressao antes do =")
					return false
				
				numSeguido = 0
				posiIgual = percorre
				var j = 0
				while j < posiIgual:
					expressao1 = str(expressao1 + str(expressaoStr[j]))
					j += 1
			
			_:
				
				if regex.search(expressaoStr[percorre]) != null and numSeguido == 1:
					print("Erro dois numeros sem operação")
					return false
				elif regex.search(expressaoStr[percorre]) != null:
					numSeguido = 1
				else:
					numSeguido = 0
		percorre += 1
	
	if posiIgual == 0:
		print("Erro operação sem igual")
		return false
	elif estado != null:
		print("Erro na expressao depois do =")
		return false
	
	var j = posiIgual+1
	while j < expressaoStr.size():
		expressao2 = str(expressao2 + str(expressaoStr[j]))
		j += 1
	
	print("expressão 1 final: %s" % [expressao1])
	print("expressão 2 final: %s" % [expressao2])
	
	var result1 = resolve(expressao1)
	var result2 = resolve(expressao2)
	if result1 == "Erro":
		print("Erro na primeira expressão")
		return false
	elif result2 == "Erro":
		print("Erro na segunda expressão")
		return false
	
	print("Resultado 1: %s" % [result1])
	print("Resultado 2: %s" % [result2])
	if result1 == result2:
		return true
	else:
		return false

func resolve(command):
	var error = expression.parse(command, [])
	if error != OK:
		print(expression.get_error_text())
		return "Erro"
	var result = expression.execute([], null, true)
	if not expression.has_execute_failed():
		return str(result)
	else:
		return "Erro"

func fatorial(n):
	if int(n) < 0 or float(n) != float(int(n)):
		return "Erro"
	if int(n) > 15:
		return "Overflow"
	var result = 1
	var i = 1
	while i <= int(n):
		result = result * i
		i += 1
	return str(result)
