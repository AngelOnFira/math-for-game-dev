extends Spatial

onready var piece = preload("res://Scenes/Piece.tscn")
var change_occured = false
var ready_to_reset = false

func _init():
	randomize()

func _ready():
	_spawn_pieces()
	
func _process(delta):
	change_occured = false

func matrix_element_change(type, element, value, change):
	if not change_occured:
		change_occured = true
	else:
		return
		
	if type == "translation":
		var translation = $MovePiece.get_translation()
		if element == "x":
			translation.x = value
		elif element == "y":
			translation.y = value
		elif element == "z":
			translation.z = value
			
		$MovePiece.set_translation(translation)

	elif type == "rotate x":
		$MovePiece.rotate_x(deg2rad(change))
		
	elif type == "rotate y":
		$MovePiece.rotate_y(deg2rad(change))
	
	elif type == "rotate z":
		$MovePiece.rotate_z(deg2rad(change))

	var move_piece_transform = $MovePiece.get_global_transform()
	var goal_piece_transform = $GoalPiece.get_global_transform()

	if (move_piece_transform.basis.get_euler() == goal_piece_transform.basis.get_euler() and
		move_piece_transform.origin == goal_piece_transform.origin):
		ready_to_reset = true
		print("ready")
	else:
		ready_to_reset = false


func _on_Accept_pressed():
	var parent_transform = $MovePiece.get_global_transform()
	print(parent_transform.basis)
	print(parent_transform.origin)
	for child in $MovePiece.get_children():
		var child_transform = child.get_global_transform()
		var new_child_transform = Transform(
			parent_transform.basis.x
		)
		child.set_global_transform(new_child_transform)

		child.get_parent().remove_child(child)
		$Pieces.add_child(child)

func _spawn_pieces():
	var move_piece = piece.instance()
	move_piece.name = "MovePiece"
	var goal_piece = piece.instance()
	goal_piece.name = "GoalPiece"
	print(move_piece.material)
	print(goal_piece.material)
	
	#goal_piece.get_child(0).material.flags_transparent = true
	#goal_piece.get_child(0).material.albedo_color.a = 0.5
	
	add_child(move_piece)
	add_child(goal_piece)
	
	var translation = goal_piece.get_translation()
	translation.z = randi() % 6 - 3
	translation.x = randi() % 6 - 3
	goal_piece.rotate_x(deg2rad(randi() % 6 - 3) * 90)
	goal_piece.rotate_y(deg2rad(randi() % 6 - 3) * 90)
	goal_piece.rotate_z(deg2rad(randi() % 6 - 3) * 90)
	goal_piece.set_translation(translation)

func _reset_level():
	if ready_to_reset:
		for child in $CanvasLayer/TabContainer.get_children():
			for element in child.get_node("GridContainer").get_children():
				element.get_node("HSlider").value = 0

		$MovePiece.queue_free()
		$GoalPiece.queue_free()
		$GoalPiece.name = "DeadGoalPiece"
		$MovePiece.name = "DeadMovePiece"
		
		_spawn_pieces()
		ready_to_reset = false
