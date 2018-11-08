extends KinematicBody2D

# grid tile set
# https://github.com/GDquest/Godot-engine-tutorial-demos/tree/master/2018/06-09-grid-based-movement 

var mouse_position = Vector2()
var is_pressed = false
var is_mouse_over = false
var columns = 16
var rows = 7
var grid_size = 64

var position_offset_x = null
var position_offset_y = null

var is_rotating = false
var is_removing = false
var is_clicked = false
var is_dropped
var is_small = true

var x_sprite
var x_text
var x_size

onready var pieces_array = [
	preload("res://Pieces/Piece_S.tscn"),
	preload("res://Pieces/Piece_T.tscn"),
	preload("res://Pieces/Piece_L.tscn"),
	preload("res://Pieces/Piece_Block.tscn"),
	preload("res://Pieces/Piece_Plus.tscn")
]

func _ready():
	pass

func _process(delta):
	# get mouse location
	mouse_position = get_global_mouse_position()
	
	# right mouse clicked
	if Input.is_mouse_button_pressed(BUTTON_RIGHT): 
		# we're over the piece
		if is_mouse_over:
			# if we're not rotating already, rotate 90 deg
			if is_rotating == false:
				is_rotating = true
				rotate(deg2rad(90))
	else:
		# stop rotate when unclicked
		is_rotating = false
		
	
	
	# Left mouse button was pressed
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		# mouse is over the space
		if is_mouse_over: 
			is_clicked = true
	else:
		is_clicked = false
		
	if is_clicked:
		is_dropped = false;
		if is_small:
			# if it's a small piece, expand it and put it on the stage
			if scale != Vector2(1,1):
				var small_position = position
				scale = Vector2(1,1)
				position.x = 448
				position.y = 320
				is_small = false
				
				# add new shape
				var index_random = round(rand_range(0,4))
				var piece_small = pieces_array[index_random].instance()
				piece_small.scale = Vector2(.3,.3)
				piece_small.position = small_position
				get_parent().add_child(piece_small)
		else:
			# wherever you click is where the piece should move with
			if position_offset_x == null:
				# the difference of out mouse position with the piece position
				position_offset_x = mouse_position.x - position.x
			if position_offset_y == null:
				# the difference of out mouse position with the piece position
				position_offset_y = mouse_position.y - position.y
			
			position.x = mouse_position.x - position_offset_x
			position.y = mouse_position.y - position_offset_y
	else:
		position_offset_x = null
		position_offset_y = null
		
		# snap the sprite into place
		if not is_dropped:
			if not is_small:
				# remove if off screen
				if (position.y > 440 or position.y < 5) and is_pressed == false and not is_removing:
					is_removing = true
					get_parent().remove_child(self)
				
				#load_piece()
				if (position.x > 1024 or position.x < 0) and is_pressed == false and not is_removing:
					is_removing = true
					get_parent().remove_child(self)
			
				if not is_removing:	
					# get the closest grid position of where the piece was dropped
					position.x = round(position.x / grid_size) * grid_size
					position.y = round(position.y / grid_size) * grid_size
				
			is_dropped = true
			is_removing = false	

func _on_Piece_mouse_entered():
	is_mouse_over = true

func _on_Piece_mouse_exited():
	is_mouse_over = false

func _on_Piece_input_event(viewport, event, shape_idx):
	#print(event)
	pass # replace with function body
