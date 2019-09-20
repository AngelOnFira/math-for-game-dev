extends Label

var editable := false
var type: String = ""

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
	emit_signal("element_change", type, value)
	if editable:
		$".".text = String(value)
