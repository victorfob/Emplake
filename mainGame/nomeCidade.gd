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
	
	textoFile = f.get_as_text().strip_edges()
	
	var nomes = textoFile.split('\n')
	var cidade = nomes[randi() % nomes.size()]
	
	bbcode_enabled = true
	
	bbcode_text = "[center]" + cidade + "[/center]"
	
	f.close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

