extends Label

var editable := false
var type: String = ""
var element: String = ""
var last_val := 0

signal element_change

func _ready():
	connect("element_change", get_node("/root/Spatial"), "matrix_element_change")

func _on_Element_mouse_entered():
	if editable:
		$HSlider.set_visible(true)


func _on_Element_mouse_exited():
	if editable:
		$HSlider.set_visible(false)


func _on_HSlider_mouse_entered():
	if editable:
		$HSlider.set_visible(true)


func _on_HSlider_mouse_exited():
	if editable:
		$HSlider.set_visible(false)

func _on_HSlider_value_changed(value):
	if editable:
		emit_signal("element_change", type, element, value, (value - last_val) * 90)
		last_val = value
	
		if !(element in ["x", "y", "z"]):
			for sibiling in get_parent().get_parent().theta:
				sibiling.text = element + " " + String(value * 90)
		else:
			$".".text = String(value)
