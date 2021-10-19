extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var file = 'res://mainGame/CidadeTxt.tres'

# Called when the node enters the scene tree for the first time.
func _ready():
	var f = File.new()
	var textoFile
	
	f.open(file, File.READ)
	
	textoFile = f.get_as_text()
	
	var cidade = textoFile.split("\n")

	text = cidade[randi() % cidade.size()]
	

	f.close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

