extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var file = 'res://mainGame/TutorialTxt.tres'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ItemList_item_selected(index):
	var f = File.new()
	var textoFile
	var simbolo = $BgIcons/ItemList.get_item_text(index)
	
	f.open(file, File.READ)
	
	while not f.eof_reached():
		textoFile = f.get_line()
		if textoFile == simbolo:
			var textoLabel = ""
			textoFile = f.get_line()
			while not textoFile == "#":
				textoLabel = str(textoLabel + str(textoFile))
				textoFile = f.get_line()
				textoLabel = str(textoLabel + "\n")
			get_node("TextTutorial").text = textoLabel
		break;
	f.close()



func _on_FecharTuM_pressed():
	get_parent().get_node("Tutorial").visible = false
	get_node("TextTutorial").text = "	Selecione um dos simbolos ao lado."
