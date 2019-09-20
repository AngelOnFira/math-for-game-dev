extends Label

var editable := false
var type: String = ""

signal element_change

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("element_change", get_parent().get_parent().get_parent().get_parent(), "test")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


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
	emit_signal("element_change", type)
	if editable:
		$".".text = String(value)
