extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var timer
var left_wall
var right_wall
var parent_node
var left_origx
var right_origx

func _ready():
	parent_node = get_parent()
	# Called when the node is added to the scene for the first time.
	# Initialization here
	timer = get_node("Timer")
	left_wall = get_node("LeftWall")
	right_wall = get_node("RightWall")
	left_origx = left_wall.position.x
	right_origx = right_wall.position.x

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Timer_timeout():
	if parent_node.game_on:
		#print(left_wall.position.x)
		#print(right_wall.position.x)
		left_wall.position.x = left_wall.position.x + 64
		right_wall.position.x = right_wall.position.x - 64
		if left_wall.position.x > 64: 
			parent_node.game_on = false
		#print(left_wall.get_colliding_bodies())
		#print(right_wall.get_colliding_bodies())
