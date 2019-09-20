extends Spatial

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	$Piece.rotate_x(1 * delta)
	$Piece.rotate_y(1 * delta)
	$Piece.rotate_z(1 * delta)

func matrix_element_change(type, value):
	if type in ["x", "y", "z"]:
		var translation = $Piece.get_translation()
		
		if type == "x":
			translation.x = value
		elif type == "y":
			translation.y = value
		elif type == "z":
			translation.z = value
		
		$Piece.set_translation(translation)
