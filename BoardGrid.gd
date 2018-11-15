extends TileMap

onready var pieces_array = [
	preload("res://Pieces/Piece_S.tscn"),
	preload("res://Pieces/Piece_T.tscn"),
	preload("res://Pieces/Piece_L.tscn"),
	preload("res://Pieces/Piece_Block.tscn"),
	preload("res://Pieces/Piece_Plus.tscn")
]

var index_left
var index_mid
var index_right

var inst
var piece_left_small
var piece_mid_small
var piece_right_small
var begin_scale = .3
var piece_is_clicked = false
var clicked_instance
var clicked_name
var mouse_over_name

func _ready():
	load_pieces()

func _process(delta):
	pass
	
func load_pieces():
	randomize()
	load_left_piece()
	load_mid_piece()
	load_right_piece()
	
		
func load_left_piece():
	index_left = round(rand_range(0,4))
	piece_left_small = pieces_array[index_left].instance()
	piece_left_small.scale = Vector2(begin_scale,begin_scale)
	piece_left_small.position.x = 380
	piece_left_small.position.y = 520
	add_child(piece_left_small)
	
func load_mid_piece():
	index_mid = round(rand_range(0,4))
	piece_mid_small = pieces_array[index_mid].instance()
	piece_mid_small.scale = Vector2(begin_scale,begin_scale)
	piece_mid_small.position.x = 480
	piece_mid_small.position.y = 520
	add_child(piece_mid_small)
	
func load_right_piece():
	index_right = round(rand_range(0,4))
	piece_right_small = pieces_array[index_right].instance()
	piece_right_small.scale = Vector2(begin_scale,begin_scale)
	piece_right_small.position.x = 580
	piece_right_small.position.y = 520
	add_child(piece_right_small)