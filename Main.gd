extends Node2D

var game_on
var left_wall
var right_wall
var wall
var board_grid

func _ready():
	game_on = true
	wall = get_node("Walls")
	left_wall = wall.get_node("LeftWall")
	right_wall = wall.get_node("RightWall")
	board_grid = get_node("BoardGrid")
	pass

func _process(delta):
	if not game_on:
		get_node("GameOver").visible = true
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button_pressed():
	game_on = true
	get_node("GameOver").visible = false
	left_wall.position.x = wall.left_origx
	right_wall.position.x = wall.right_origx
	for piece in board_grid.get_children():
		board_grid.remove_child(piece)
	board_grid.load_pieces()
