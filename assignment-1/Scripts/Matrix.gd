extends Control

var translation_matrix = [
	[1, 0, 0, 0],
	[0, 1, 0, 0],
	[0, 0, 1, 0],
	["x", "y", "z", 1],
]

func _ready():	
	
	var element_count = 0
	for row in translation_matrix:
		for element in row:
			var matrix_element = $GridContainer.get_child(element_count)
			element_count += 1
			
			if typeof(element) == TYPE_STRING:
				matrix_element.editable = true
				matrix_element.add_color_override("font_color", Color(0,1,0))
				matrix_element.type = element
			elif element != 0:
				matrix_element.text = String(element)
