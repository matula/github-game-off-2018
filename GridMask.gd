extends Area2D

var grid_node
var entered_shape

func _ready():
	grid_node = get_parent().get_node("BoardGrid")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_GridMask_body_entered(body):
	entered_shape = grid_node.clicked_name


func _on_GridMask_body_shape_entered(body_id, body, body_shape, area_shape):
	pass # replace with function body


func _on_GridMask_body_exited(body):
	entered_shape = null
