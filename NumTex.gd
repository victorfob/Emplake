extends TextEdit


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(int) var LIMIT = 4
var current_text = ""
var cursor_line = 0
var cursor_column = 0
var regex = RegEx.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	regex.compile("^[0-9]*$")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node("../Especifico").pressed == true:
		readonly = false
	else:
		readonly = true

func _on_TextEdit_text_changed():
	var new_text : String = text
	if new_text.length() > LIMIT or !regex.search(new_text):
		text = current_text
		# when replacing the text, the cursor will get moved to the beginning of the
		# text, so move it back to where it was 
		cursor_set_line(cursor_line)
		cursor_set_column(cursor_column)
	
	current_text = text
	# save current position of cursor for when we have reached the limit
	cursor_line = cursor_get_line()
	cursor_column = cursor_get_column()

