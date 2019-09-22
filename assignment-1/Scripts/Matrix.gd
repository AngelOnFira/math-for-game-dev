extends Control

export(String, "translation", "rotate x", "rotate y", "rotate z") var matrix_type
var theta = []

var translation_matrix = [
	[1, 0, 0, 0],
	[0, 1, 0, 0],
	[0, 0, 1, 0],
	["x", "y", "z", 1],
]

var rotation_x_matrix = [
	[1, 0, 0, 0],
	[0, "cos", "sin", 0],
	[0, "-sin", "cos", 0],
	[0, 0, 0, 1],
]

var rotation_y_matrix = [
	["cos", 0, "-sin", 0],
	[0, 1, 0, 0],
	["sin", 0, "cos", 0],
	[0, 0, 0, 1],
]

var rotation_z_matrix = [
	["cos", "sin", 0, 0],
	["-sin", "cos", 0, 0],
	[0, 0, 1, 0],
	[0, 0, 0, 1],
]

func _ready():
	
	var matrix_used
	
	if matrix_type == "translation":
		matrix_used = translation_matrix
	elif matrix_type == "rotate x":
		matrix_used = rotation_x_matrix
	elif matrix_type == "rotate y":
		matrix_used = rotation_y_matrix
	elif matrix_type == "rotate z":
		matrix_used = rotation_z_matrix
	
	var element_count = 0
	for row in matrix_used:
		for element in row:
			var matrix_element = $GridContainer.get_child(element_count)
			element_count += 1
			
			if typeof(element) == TYPE_STRING:
				matrix_element.editable = true
				matrix_element.add_color_override("font_color", Color(0,1,0))
				matrix_element.type = matrix_type
				matrix_element.element = element
				if !(element in ["x", "y", "z"]):
					matrix_element.text = element + " 0"
					theta.append(matrix_element)
			elif element != 0:
				matrix_element.text = String(element)
