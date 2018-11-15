extends RigidBody2D

# grid tile set
# https://github.com/GDquest/Godot-engine-tutorial-demos/tree/master/2018/06-09-grid-based-movement 

var mouse_position = Vector2()
var is_pressed = false
var is_mouse_over
var columns = 16
var rows = 7
var grid_size = 64

var position_offset_x = null
var position_offset_y = null

var is_rotating = false
var is_removing = false
var is_clicked = false
var is_dropped = true
var is_small = true
var click_once = false
var clicked_instance

var x_sprite
var x_text
var x_size

var parent_node
var grid_mask_node
var dropped_body
var hovering_over

onready var pieces_array = [
	preload("res://Pieces/Piece_S.tscn"),
	preload("res://Pieces/Piece_T.tscn"),
	preload("res://Pieces/Piece_L.tscn"),
	preload("res://Pieces/Piece_L_back.tscn"),
	preload("res://Pieces/Piece_Block.tscn"),
	preload("res://Pieces/Piece_Plus.tscn")
]

func _ready():
	parent_node = get_parent()
	grid_mask_node = parent_node.get_parent().get_child(0)

func _process(delta):
	# get mouse location
	mouse_position = get_global_mouse_position()
	#print('mouse over: ' + str(parent_node.mouse_over_name))
	#print('clicked: ' + str(parent_node.clicked_name))
	
	# right mouse clicked
	if Input.is_mouse_button_pressed(BUTTON_RIGHT): 
		if not is_small:
			# we're over the piece
			if parent_node.mouse_over_name == get_name():
				# if we're not rotating already, rotate 90 deg
				if is_rotating == false:
					is_rotating = true
					rotate(deg2rad(90))
	else:
		# stop rotate when unclicked
		is_rotating = false
	
	# if this piece is small and you click once	
	if is_small:
		if Input.is_action_just_pressed('mouse_click'):
			# and your mouse is ON the piece
			if parent_node.mouse_over_name == get_name():
				# make sure it's not already scaled up
				if scale != Vector2(1,1):
					# get the origina position of this piece while small
					var small_position = position
					# set a global var to track which piece was clicked
					parent_node.clicked_name = get_name()
					is_dropped = false
					# set the scale to regular size
					scale = Vector2(1,1)
					# place it on top of everything
					z_index = 1
					parent_node.mouse_over_name = get_name()
					# no longer small
					is_small = false
				
					# add new small shape at the last shape's position
					var index_random = round(rand_range(0,4))
					var piece_small = pieces_array[index_random].instance()
					piece_small.scale = Vector2(.3,.3)
					piece_small.position = small_position
					get_parent().add_child(piece_small)
	else:
		# code for the big piece				
		# Left mouse button was pressed
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			# mouse is over the shape
			if parent_node.mouse_over_name == get_name(): 
				if parent_node.clicked_name != get_name():
					parent_node.clicked_name = get_name()
					is_clicked = true
					is_dropped = false
					print('just clicked: ' + get_name())
		else:
			is_clicked = false
		
		if is_clicked:
			# only move piece that matches global clicked id
			if parent_node.clicked_name == get_name():
				if parent_node.mouse_over_name == null:
					parent_node.mouse_over_name = get_name()
				# put clicked shape on top
				move_piece()
		else:
			if parent_node.clicked_name == get_name():
				drop_piece()
			
			

func _on_Piece_mouse_entered():
	# we haven't clicked a shape yet, but are hovering over one
	if parent_node.clicked_name == null and parent_node.mouse_over_name == null:
		parent_node.mouse_over_name = get_name()

func _on_Piece_mouse_exited():
	# reset the hovering name
	parent_node.mouse_over_name = null

func _on_Piece_input_event(viewport, event, shape_idx):
	#print(event)
	pass # replace with function body


func _on_Piece_body_shape_entered(body_id, body, body_shape, local_shape):	
	pass # replace with function body


func _on_Piece_body_entered(body):
	if body.get_name() != parent_node.clicked_name:
		if hovering_over == null:
			hovering_over = body.get_name()
			print('clicked hover piece: ' + str(parent_node.clicked_name))
			print('hovering over: ' + hovering_over)


func _on_Piece_body_exited(body):
	if body.get_name() != parent_node.clicked_name:
		print('exited piece: ' + body.get_name())
		print('exited clicked: ' + str(parent_node.clicked_name))
		if hovering_over != null:
			hovering_over = null
			
func move_piece():
	# put clicked shape on top
	z_index = 1
	# piece has not been dropped yet
	is_dropped = false
	# wherever you click is where the piece should move with
	if position_offset_x == null:
		# the difference of the mouse position with the piece position
		position_offset_x = mouse_position.x - position.x
	if position_offset_y == null:
		# the difference of the mouse position with the piece position
		position_offset_y = mouse_position.y - position.y
	
	# set the position of the piece to follow the mouse		
	position.x = mouse_position.x - position_offset_x
	position.y = mouse_position.y - position_offset_y


	
func drop_piece():
	# reset the offset
	position_offset_x = null
	position_offset_y = null
	
	# the piece has not been dropped yet
	if not is_dropped:	
		# shape was dragged off board, remove if off screen	
		if grid_mask_node.entered_shape == parent_node.clicked_name:
			is_removing = true
			get_parent().remove_child(self)
		
			
		# we're not removing it, we're just dropping it on the grid	
		if not is_removing:	
			# get the closest grid position of where the piece was dropped
			position.x = round(position.x / grid_size) * grid_size
			position.y = round(position.y / grid_size) * grid_size
			# put shape back to bottom
			z_index = 0
			print('dropped piece is hovering over: ' + str(hovering_over))
			print(get_colliding_bodies())

			
	parent_node.clicked_name = null	
	is_dropped = true
	is_removing = false
				
	

	