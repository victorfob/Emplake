extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (String) var nome = '0'
export (Vector3) var posiIni = Vector3(0,0,0)
var nodeArea
var posicaoEqua
var remove = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	posiIni = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if remove == 1:
		nodeArea.removeElem(self)

func setPosiEqua(var posi):
	posicaoEqua = posi

func change_position(x):
	posiIni.x = x
	global_position = posiIni

func remove():
	remove = 1
