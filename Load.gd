extends Node


var numeros
enum dificuldade {Facil, Medio, Dificil}
var dif = dificuldade.Dificil
var pause = false
var modo
var todosTutoriais = []
var tutorialNum = 0
var operacoesTutorial = [];
var numerosTutorial = []
#mais menos mult divi pote raiz fatorial parente modulo tetochao igual;
var operacoes = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var tutorial0 = [1,0,0,0,0,0,0,0,0,0,0,1];
	operacoesTutorial.insert(0,tutorial0);
	numerosTutorial.insert(0,"0000");
	
	var tutorial1 = [0,1,0,0,0,0,0,0,0,0,0,1];
	operacoesTutorial.insert(1,tutorial1);
	numerosTutorial.insert(1,"1111");
	
	var tutorial2 = [1,1,0,0,0,0,0,0,0,0,0,1];
	operacoesTutorial.insert(2,tutorial2);
	numerosTutorial.insert(2,"2222")
	
	var tutorial3 = [0,0,0,0,0,0,0,0,0,0,0,1];
	operacoesTutorial.insert(3,tutorial3);
	numerosTutorial.insert(3,"0000");
	
	var tutorial4 = [0,0,0,0,0,0,0,0,0,0,0,1];
	operacoesTutorial.insert(4,tutorial4);
	numerosTutorial.insert(4,"0000");
	
	var tutorial5 = [0,0,0,0,0,0,0,0,0,0,0,1];
	operacoesTutorial.insert(5,tutorial5);
	numerosTutorial.insert(5,"0000");
	
	var tutorial6 = [0,0,0,0,0,0,0,0,0,0,0,1];
	operacoesTutorial.insert(6,tutorial6);
	numerosTutorial.insert(6,"0000")
	
	var tutorial7 = [0,0,0,0,0,0,0,0,0,0,0,1];
	operacoesTutorial.insert(7,tutorial7);
	numerosTutorial.insert(7,"0000");
	
	var tutorial8 = [0,0,0,0,0,0,0,0,0,0,0,1];
	operacoesTutorial.insert(8,tutorial8);
	numerosTutorial.insert(8,"0000");
	
	var tutorial9 = [0,0,0,0,0,0,0,0,0,0,0,1];
	operacoesTutorial.insert(9,tutorial9);
	numerosTutorial.insert(9,"0000")
	
	var tutorial10 = [0,0,0,0,0,0,0,0,0,0,0,1];
	operacoesTutorial.insert(10,tutorial10);
	numerosTutorial.insert(10,"0000");
	
	var tutorial11 = [1,0,0,0,0,0,0,0,0,0,0,1];
	operacoesTutorial.insert(11,tutorial11);
	numerosTutorial.insert(11,"0000");