extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var cube: MeshInstance = $MeshInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cube.rotate_y(0.1)
