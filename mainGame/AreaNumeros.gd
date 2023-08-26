extends Node2D


#struct que guarda os elementos da equação
class valoresEquacao:
	#caminho ao objeto
# warning-ignore:unused_class_variable
	var patch: Node2D
	#identificador do elemento
# warning-ignore:unused_class_variable
	var nome: String
	#posição x do elemento na equação
# warning-ignore:unused_class_variable
	var x: float
	var pathCriador: Node2D

#variavel que guarda a expressao para computação final
var expressaoStr = []
#variavel gerada para função do godot de resolver operações
onready var expression = Expression.new()
#variavel que guarda a struct com todos os elementos da equação
var equacao = []
#total de elementos na equação
var total = 0
#variavel usada achar os numeros na string
var regex = RegEx.new()
#varivel que guarda o espaçamento entre elementos da equação
export (int) var deslocamento = 58
#timer
var timer
#timer txt
var timerText
#valor base do score
var scoreBase = 0
var finalResult = null
#variaveis usadas como saida da função que resolve a operação
var valorMetade1
var valorMetade2
var money = 2000
var scoreAdventure = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timerText = get_parent().get_node("HUD/TimerHud/TimerTxt")
	
	#faz o regex aceitar apenas numeros
	regex.compile("^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$")
	
	if Load.modo == 4:
		timerText.text = str("Dinheiro: " + str(money) + "$")
		get_parent().get_node("HUD/ScoreHud/ScoreTxt").text = str("Score: " + str(scoreAdventure))
		get_parent().get_node("PauseButton").visible = false
	elif Load.modo == 3:
		get_parent().get_node("PauseButton").visible = false
		get_parent().get_node("HUD/ScoreHud/ScoreTxt").visible = false 
	else:
		timer = get_parent().get_node("HUD/TimerHud/Timer")
		timer.start(30)
	pass # Replace with function body.


func _process(delta):
	if Load.modo != 4 and Load.modo != 3:
		timerText.text = str("Tempo: "+ str(round(timer.time_left)))

#função que reajusta a posição de todos os elementos da função na tela
#usa as posição do vetor equação[] para determinar as posições
func atualizarFunc():
	var i = 0
	while i < equacao.size():
		#atualiza a posição do elemento no script dele
		equacao[i].patch.setPosiEqua(i)
		#calculo da nova posição
		if((total-1) %2 == 0):
			equacao[i].x = global_position.x + (deslocamento *(i - (total-1)/2))
		else:
			equacao[i].x = (global_position.x - deslocamento/2) + (deslocamento *(i - (total-1)/2))
		#atualiza a posição na tela
		equacao[i].patch.change_position(equacao[i].x)
		i += 1
	calcScore()
	if (comecarPrint() == true):
		get_parent().get_node("Enviar")._on_Enviar_pressed()

#função que adiciona elementos a equação
func novoElem(node):
	if total < 13:
		#inicia o elemento com seus respectivos valores
		var novoEle = valoresEquacao.new()
		novoEle.patch = node
		novoEle.nome = node.nome
		
		#busca a posição que o elemento realmente deveria estar
		var i = 0
		var xPosi = node.get_global_position().x
		while i < equacao.size():
			#basea-se na posição do elemento na hora que o mouse libera o elemento
			if  xPosi < equacao[i].x:
				break
			i += 1
		
		#salva a posição que o elemento esta
		novoEle.patch.setPosiEqua(i)
		novoEle.x = xPosi
		#insere o elemento na equacao[]
		equacao.insert(i,novoEle)
		#salva o patch para o botao que criou a operacao
		novoEle.pathCriador = node.pathCriador
		if node.pathCriador != null: #em caso de ser um numero
			#atualiza o numero de operacoes criadas desse tipo
			novoEle.pathCriador.addNovoEle()
		#aumenta o total de elementos
		total += 1
		#atualiza a posição na tela
		atualizarFunc()
	else:
		node.free()

#função usada para reposicionar 1 elemento
func novaPosiElem(node):
	#pega a nova posição x do elemento
	var xPosi = node.get_global_position().x
	#se não mudou então cancela a função
	if xPosi == equacao[node.posicaoEqua].x:
		return
	
	#salva o elemento e uma variavel temporaria
	var temp = equacao[node.posicaoEqua]
	#reove o elemento da equação
	equacao.remove(node.posicaoEqua)
	
	#encontra a nova posição do elemento
	var i = 0
	while i < equacao.size():
		if  xPosi < equacao[i].x:
			break
		i += 1
	#insere o elemento na posição devida da equação
	equacao.insert(i,temp)
	#ajusta a posição a tela
	atualizarFunc()

#função que remove elementos da equação
func removeElem(node):
	if node.pathCriador != null: #em caso de ser um numero
		node.pathCriador.removeEle()
	equacao.remove(node.posicaoEqua)
	total -= 1
	node.free()
	atualizarFunc()

#função que deleta todos os elementos menos os numeros
func limpar():
	var i = total-1
	while i >= 0:
		if !regex.search(equacao[i].nome):
			if equacao[i].pathCriador != null: #em caso de ser um numero
				equacao[i].pathCriador.removeEle()
			equacao[i].patch.free()
			equacao.remove(i)
		i-= 1
	total = 4
	atualizarFunc()

#função que deleta todos os elementos
func limparTudo():
	var i = total-1
	while i >= 0:
		equacao[i].patch.free()
		equacao.remove(i)
		i-= 1
	total = 0
	atualizarFunc()

#função que começa a executar a operação
func comecarPrint():
	var i = 0
	var j = 0
	var metade = 1
	var igual = 0
	var resultado1
	var resultado2
	expressaoStr.clear()
	#while que passa todos os elementos para um vertor string
	while i < total:
		if(equacao[i].nome == "="):
			igual += 1
			if(igual > 1):
				valorMetade1 = "Mais de um igual na operação"
				valorMetade2 = "Mais de um igual na operação"
				return false
			print(expressaoStr)
			resultado1 = printEqua(0, i, null, metade)
			expressaoStr.clear()
			j = 0
			i += 1
			if i >= total:
				valorMetade1 = "Igual em local errado"
				valorMetade2 = "Igual em local errado"
				return false;
			metade = 2
		expressaoStr.append("")
		#esse vetor tera seu valor mudado ao decorrer da função
		#por esse motivo não se pode usar equacao[].nome mesmo que os dois 
		#comecem com os valores identicos
		expressaoStr[j] = equacao[i].nome
		i += 1
		j += 1
	if(igual == 0):
		valorMetade1 = "Expressão sem ="
		valorMetade2 = "Expressão sem ="
		return false
	else:
		resultado2 = printEqua(0, j, null, metade)
		
	if (resultado1 == true && resultado2 == true):
		if(valorMetade1 == valorMetade2):
			finalResult = valorMetade1
			if Load.modo != 4 and Load.modo != 3:
				timer.stop()
			return true
	return false

#função recursiva que trasforma um vetor de string 
#em uma operação matematica e calcula a mesma
#inicio é o ponto no qual a o vetor String deve começar a trabalhar
#fim é o ponto de parada do vetor
#estado serve para as recursões que ocorrem quando a operação abre um tipo de separador((,{,[,|)
#metade determina qual metade do problema esta sendo trabalhada
func printEqua(var inicio,var fim, var estado, var metade):
	#variavel que diz onde o vetor string deve ler
	var percorre = inicio

	#variavel que salva o string da operação
	var expressao = ""
	
	#variavel que detecta se dois numeros estão sem operadores entre eles
	var numSeguido = 0
	
	#while que percorre o vetor string com a equação
	while percorre < fim:
		#match que le o vetor
		match expressaoStr[percorre]:
			#se uma das operações for:
			#( = abre parenteses
			#| = começo do modulo
			#[ = abertura do teto
			#{ = abertura do piso
			"(", "|", "[", "{":
				#chama a recursão da função dizendo o tipo
				#usar percorre+1 para ignorar o simbolo atual
				if printEqua(percorre + 1, fim, expressaoStr[percorre], metade) == false:
					#se o retorno foi falso, ocorreu algum erro durante a recursao
					print("Erro recurssão")
					return false
				#se não ocorreu erro na recursão, retira o simboloa atual do vetor equação
				expressaoStr.remove(percorre)
				#atualiza o tamanho do vetor
				fim = expressaoStr.size()
			
			#se uma das operações for:
			#) = fecha parenteses
			#I = fim do modulo
			#] = fim do teto
			#} = fim do piso
			")", "I", "]", "}":
				#variavel que salva para cada simbolo o 
				#estado esperado para o mesmo
				var tipo = ""
				if expressaoStr[percorre] == ")":
					tipo = "("
				elif expressaoStr[percorre] == "I":
					tipo = "|"
				elif expressaoStr[percorre] == "]":
					tipo = "["
				else:
					tipo = "{"
				
				#checa se o estado e o tipo estão corretos
				if estado != tipo:
					#se não tiverem a operação não é valida
					print("Erro fechando expressao na hora errada")
					if(metade == 1):
						valorMetade1 = "Erro usando %s na hora errada" %expressaoStr[percorre]
					else:
						valorMetade2 = "Erro usando %s na hora errada" %expressaoStr[percorre]
					return false
					
				#variavel que ira salvar a expressao que esta 
				#entre esse setor(ex: do { ate }) da operação
				var expressaoSetor = ""
				#passa todos os simbolos desse setor(ex: do { ate }) em uma string
				while inicio <= percorre:
					#acressenta o string do vetor no string da expressao
					expressaoSetor = str(str(expressaoStr[percorre])+ expressaoSetor)
					#remove o valor do vetor
					expressaoStr.remove(percorre)
					#reduz o percorre
					percorre -= 1
				
				#usa o resolve do godot para calcular o valor na string expressao
				var result = resolve(expressaoSetor)
				
				#verifica se ocorreu um erro com o resolve
				if result == "Erro":
					#se sim, então tem algo errado nesse setor da expressão
					print("Erro na expressao")
					if(metade == 1):
						valorMetade1 = "Erro de sintaxe"
					else:
						valorMetade2 = "Erro de sintaxe"
					return false
				
				#operações realizada para os diferentes tipos que podem ser
				#executadas nessa parte o match
				if tipo == "|":
					#faz o modulo do resultado
					if int(result) < 0:
						result = str(float(result) * -1)
				elif tipo == "{":
					#faz o chao do resultado
					result = str(floor(float(result)))
				elif tipo == "[":
					#faz o teto do resultado
					result = str(int(ceil(float(result))))
				
				#print temporario
				print("Resultado da fechagem da operação: %s" % [result])
				
				#insere o valor retornado na posuição correta do vetor String
				expressaoStr.insert(percorre+1, result)
				#retorna o sucesso da operação
				return true
			
			#se for elevado
			"^":
				#checa se o valor a frente esta desntro de algum tipo de separador
				if (expressaoStr[percorre + 1] == "(" 
				or expressaoStr[percorre + 1] == "|" 
				or expressaoStr[percorre + 1] == "[" 
				or expressaoStr[percorre + 1] == "{"):
					#se sim, então usando recursão resolve esse valor antes de
					#calcular a elevação
					if printEqua(percorre + 2, fim, expressaoStr[percorre+1], metade) == false:
						#se retornar falso, então tem um problema nesse setor da operação
						print("Erro na recurssão durante ^")
						return false
					#se ta tudo certo, remove o simbolo que iria abrir o separador
					#ja que o valor ja foi calculado
					expressaoStr.remove(percorre+1)
					#atualiza o tamanho do vetor String
					fim = expressaoStr.size()
				
				#passa os valores do vetor String em uma string que pode ser calculada
				var elevado = str("pow(%s,%s)" % [expressaoStr[percorre-1], expressaoStr[percorre+1]])
				#realiza o calculo do elevado
				var result = resolve(elevado)
				
				#verifica se teve problema com o elevado
				if result == "Erro":
					print("Erro na expressao durante ^")
					if metade == 1:
						valorMetade1 = "Erro na expessão ^"
					else:
						valorMetade2 = "Erro na expessão ^"
					return false
				
				#se não teve problema, remove do vetor String os simbolos que 
				#ja foram calculados
				expressaoStr.remove(percorre+1)
				expressaoStr.remove(percorre)
				expressaoStr.remove(percorre-1)
				#print temporario
				print("Resultado elevado: %s" % [result])
				#adiciona o valor calculado na posição correta do vetor String
				expressaoStr.insert(percorre-1, result)
				#devido a remoção dos valores usados na operação, o percorre 
				# precisa voltar em 1
				percorre -= 1
				#atualiza o tamanho final da operação
				fim = expressaoStr.size()
				
			"/":
				#salva a forma de realizar uma divisão com ponto flutuante
				var divisao = str("float(%s)/" % [expressaoStr[percorre-1]])
				
				#marca a flag que detecta dois numeros seguidos como falso
				numSeguido = 0
				
				#remove os antigos simbolos usados na divisao
				expressaoStr.remove(percorre)
				expressaoStr.remove(percorre-1)
				
				#print temporario
				print("Resultado divisão: %s" % [divisao])
				#insere o novo formato da divisão no vetor String
				expressaoStr.insert(percorre-1, divisao)
				#devido a junção dos do valor e do simbolo de divisão em uma
				#unica parte do vetor o percorre precisa voltar em 1
				percorre -= 1
				#atualiza o tamanho do vetor String
				fim = expressaoStr.size()
			
			#se o simbolo for R simboliza a realização de uma raiz
			"R":
				#checa se o valor a frente esta desntro de algum tipo de separador
				if (expressaoStr[percorre + 1] == "(" 
				or expressaoStr[percorre + 1] == "|" 
				or expressaoStr[percorre + 1] == "[" 
				or expressaoStr[percorre + 1] == "{"):
					#se sim, então usando recursão resolve esse valor antes de
					#calcular a elevação
					if printEqua(percorre + 2, fim, expressaoStr[percorre+1], metade) == false:
						#se retornar falso, então tem um problema nesse setor da operação
						print("Erro na recurssão durante a raiz")
						return false
					#se ta tudo certo, remove o simbolo que iria abrir o separador
					#ja que o valor ja foi calculado
					expressaoStr.remove(percorre+1)
					#atualiza o tamanho do vetor String
					fim = expressaoStr.size()
				
				#passa os valores do vetor para um formato que pode ser calculado
				var raiz = str("sqrt(%s)" % [expressaoStr[percorre+1]])
				#calcula o resultado da raiz
				if(int(expressaoStr[percorre+1]) < 0):
					if metade == 1:
						valorMetade1 = "Erro valor negativo na raiz"
						return false
					else:
						valorMetade2 = "Erro valor negativo na raiz"
						return false
				
				var result = resolve(raiz)
				
				#verifica se deu erro na operação
				if result == "Erro":
					if metade == 1:
						valorMetade1 = "Erro na expessão de raiz"
					else:
						valorMetade2 = "Erro na expessão de raiz"
					print("Erro na expressao durante raiz")
					return false
				
				#como juntou a raiz com o proximo numero remove os valores
				#antigos do vetor
				expressaoStr.remove(percorre+1)
				expressaoStr.remove(percorre)
				
				#print temporario
				print("Resultado raiz: %s" % [result])
				#insere o resultado da raiz na posição correta
				expressaoStr.insert(percorre, result)
				#devido a união do R e do numero anterio o percorre volta 1
				percorre -= 1
				#recalcula o tamanho da operação
				fim = expressaoStr.size()
			
			#se o simbolo for R simboliza a realização de uma raiz cubica
			"C":
				#checa se o valor a frente esta desntro de algum tipo de separador
				if (expressaoStr[percorre + 1] == "(" 
				or expressaoStr[percorre + 1] == "|" 
				or expressaoStr[percorre + 1] == "[" 
				or expressaoStr[percorre + 1] == "{"):
					#se sim, então usando recursão resolve esse valor antes de
					#calcular a elevação
					if printEqua(percorre + 2, fim, expressaoStr[percorre+1], metade) == false:
						#se retornar falso, então tem um problema nesse setor da operação
						print("Erro na recurssão durante a raiz")
						return false
					#se ta tudo certo, remove o simbolo que iria abrir o separador
					#ja que o valor ja foi calculado
					expressaoStr.remove(percorre+1)
					#atualiza o tamanho do vetor String
					fim = expressaoStr.size()
				
				var raiz
				if int(expressaoStr[percorre+1]) < 0:
					#passa os valores do vetor para um formato que pode ser calculado considerando raiz negativa
					raiz = str("-pow(%d,1.0/3.0)" % [int(expressaoStr[percorre+1]) * -1])
				else:
					#passa os valores do vetor para um formato que pode ser calculado
					raiz = str("pow(%s,1.0/3.0)" % [expressaoStr[percorre+1]])
				
				var result = resolve(raiz)
				
				#verifica se deu erro na operação
				if result == "Erro":
					if metade == 1:
						valorMetade1 = "Erro na expessão de raiz"
					else:
						valorMetade2 = "Erro na expessão de raiz"
					print("Erro na expressao durante raiz")
					return false
				
				#como juntou a raiz com o proximo numero remove os valores
				#antigos do vetor
				expressaoStr.remove(percorre+1)
				expressaoStr.remove(percorre)
				
				#print temporario
				print("Resultado raiz: %s" % [result])
				#insere o resultado da raiz na posição correta
				expressaoStr.insert(percorre, result)
				#devido a união do R e do numero anterio o percorre volta 1
				percorre -= 1
				#recalcula o tamanho da operação
				fim = expressaoStr.size()
			#se o operador for o operador de fatorial
			"!":
				#verifica se o fatorial não esta na primeira casa
				if percorre <= 0:
					if metade == 1:
						valorMetade1 = "! usado na posição errada"
					else:
						valorMetade2 = "! usado na posição errada"
					print("! na posicao errada")
					return false
				
				#calcula o resultado do fatorial(no maximo faz 15 fatorial)
				var result = fatorial(expressaoStr[percorre-1])
				
				#verifica se teve erro ou overflow
				if result == "Erro":
					print("Erro na expressao durante !")
					if metade == 1:
						valorMetade1 = "Erro na expressao durante !"
					else:
						valorMetade2 = "Erro na expressao durante !"
					return false
				elif result == "Overflow":
					if metade == 1:
						valorMetade1 = "Overflow devido a ! muito grande"
					else:
						valorMetade2 = "Overflow devido a ! muito grande"
					print("Valor muito grande no !")
					return false
				
				#remove os simbolos usados durante o fatorial do vetor
				expressaoStr.remove(percorre)
				expressaoStr.remove(percorre-1)
				
				#print temporario
				print("Resultado fatorial: %s" % [result])
				#insere o resultado no vetor
				expressaoStr.insert(percorre-1, result)
				#atualiza o percorre e o tamanho da operação
				percorre -= 1
				fim = expressaoStr.size()			
			#se for qualquer outro simbolo
			_:
				#verifica se o simbolo é um numero
				print(expressaoStr[percorre])
				print(percorre)
				if regex.search(expressaoStr[percorre]) != null and numSeguido == 1:
					#se for um numero e esta depois de outro numero retorna falso
					print("Erro dois numeros sem operação")
					if metade == 1:
						valorMetade1 = "Erro dois numeros sem operação"
					else:
						valorMetade2 = "Erro dois numeros sem operação"
					return false
				elif regex.search(expressaoStr[percorre]) != null:
					#se for um numero e não esta depois de outro numero muda a flag 
					numSeguido = 1
				else:
					#se não é um numero zera a flag
					numSeguido = 0
		
		#avança o while que le o vetor String
		percorre += 1
	
	if estado != null:
		if metade == 1:
			valorMetade1 = "Erro faltou fechar %s" % estado
		else:
			valorMetade2 = "Erro faltou fechar %s" % estado
		print("Erro na expressao")
		return false
	
	var j = 0
	while j < fim:
		expressao = str(expressao + str(expressaoStr[j]))
		j += 1
	
	#print temporario
	print("expressão final: %s" % [expressao])
	
	#resolve as operações
	var result = resolve(expressao)
	
	#verifica se houve um erro na operação
	if result == "Erro":
		if metade == 1:
			valorMetade1 = "Erro de sintaxe"
		else:
			valorMetade2 = "Erro de sintaxe"
		return false

	if(metade == 1):
		valorMetade1 = result
		print("Resultado primeira metade: %s" % [result])
	else:
		valorMetade2 = result
		print("Resultado segunda metade: %s" % [result])
	return true

#função copiada do manual godot para executar as operações
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

#função para calcular fatorial
func fatorial(n):
	#checa se o valor é negativo ou quebrado
	if int(n) < 0 or float(n) != float(int(n)):
		return "Erro"
	#checa se o numero não é muito grande
	if int(n) > 15:
		return "Overflow"
	
	#calcula o fatorial
	var result = 1
	var i = 1
	while i <= int(n):
		result = result * i
		i += 1
	return str(result)


func calcScore():
	if Load.modo != 4:
		var i = 0
		var score = scoreBase
		while i < equacao.size():
			match equacao[i].nome:
				"*", "+", "-", "/":
					score += 100
				"R", "^", "!":
					score += 200
				"{","[":
					score -= 200
			i += 1
		get_parent().get_node("HUD/ScoreHud/ScoreTxt").text = str("Score: " + str(score))
		return score

func _on_Timer_timeout():
	scoreBase -= 20
	calcScore()

func getFinalResult():
	return finalResult
	
func getFinalScore():
	if Load.modo == 4:
		return scoreAdventure
	else:
		var score = calcScore()
		return score

func getValoreMetade1():
	return valorMetade1
	
func getValoreMetade2():
	return valorMetade2

func getMoney():
	return money

func atualizarPreco(var preco):
	money = money + preco
	timerText.text = str("Dinheiro: " + str(money) + "$")

func addScore():
	scoreAdventure = scoreAdventure + 1
	get_parent().get_node("HUD/ScoreHud/ScoreTxt").text = str("Score: " + str(scoreAdventure))
