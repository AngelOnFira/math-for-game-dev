extends Label

var editable := false
var type: String = ""
var element: String = ""
var last_val := 0

signal element_change
signal element_release

func _ready():
	connect("element_change", get_node("/root/Spatial"), "matrix_element_change")
	connect("element_release", get_node("/root/Spatial"), "_reset_level")

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
				sibiling.text = sibiling.element + " " + String(value * 90)
				sibiling.get_children()[0].value = value
		else:
			$".".text = String(value)


func _on_HSlider_gui_input(event):
	if event is InputEventMouseButton and not event.pressed:
		emit_signal("element_release")
