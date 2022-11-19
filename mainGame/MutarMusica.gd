extends TouchScreenButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var musicaON = preload("res://assets/imgs/musica.png")
var musicaOFF = preload("res://assets/imgs/no_musica.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Music.playing == false:
		self.normal = musicaOFF
	else:
		self.normal = musicaON
	pass


func _on_MutarMusica_pressed():
	if Music.playing == true:
		Music.stop()
		self.normal = musicaOFF
	else:
		Music.play()
		self.normal = musicaON
