extends Spatial

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	pass

func matrix_element_change(type, element, value, change):
	if type == "translation":
		var translation = $Piece.get_translation()
		if element == "x":
			translation.x = value
		elif element == "y":
			translation.y = value
		elif element == "z":
			translation.z = value
			
		$Piece.set_translation(translation)

	elif type == "rotate x":
		$Piece.rotate_x(deg2rad(change))
		
	elif type == "rotate y":
		print(type)
		$Piece.rotate_y(deg2rad(change))
	
	elif type == "rotate z":
		$Piece.rotate_z(deg2rad(change))
