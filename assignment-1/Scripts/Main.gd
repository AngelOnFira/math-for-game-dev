extends Spatial

onready var piece = preload("res://Scenes/Piece.tscn")
var change_occured = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var move_piece = piece.instance()
	move_piece.name = "MovePiece"
	var goal_piece = piece.instance()
	goal_piece.name = "GoalPiece"
	
	add_child(move_piece)
	add_child(goal_piece)
	
	var translation = goal_piece.get_translation()
	translation.z = -3
	goal_piece.rotate_y(deg2rad(90))
	goal_piece.set_translation(translation)
	
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

#	var parent_transform = $MovePiece.get_global_transform()
#	print(parent_transform.basis)
#	print(parent_transform.origin)

	var move_piece_transform = $MovePiece.get_global_transform()
	var goal_piece_transform = $GoalPiece.get_global_transform()
	
#	move_piece_transform = _clean_transform(move_piece_transform)
#	goal_piece_transform = _clean_transform(goal_piece_transform)
	
#	print(move_piece_transform.basis.get_euler())
#	print("=")
#	print(goal_piece_transform.basis.get_euler())
#	print(" ")

	if (move_piece_transform.basis.get_euler() == goal_piece_transform.basis.get_euler()):
		print("same")


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
		
func _clean_transform(transform_in):
	transform_in.basis.x = Vector3(
		int(transform_in.basis.x.x),
		int(transform_in.basis.x.y),
		int(transform_in.basis.x.z))
		
	transform_in.basis.y = Vector3(
		int(transform_in.basis.y.x),
		int(transform_in.basis.y.y),
		int(transform_in.basis.y.z))
		
	transform_in.basis.z = Vector3(
		int(transform_in.basis.z.x),
		int(transform_in.basis.z.y),
		int(transform_in.basis.z.z))
		
	return transform_in
