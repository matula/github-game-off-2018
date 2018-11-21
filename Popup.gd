extends Popup

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _on_ToolButton_pressed():
	print('pressed popup')
	popup()
	pass # replace with function body
