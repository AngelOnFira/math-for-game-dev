extends Spatial

onready var cube = preload("res://Scenes/Cube.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

var t_shape = [
	[
		[0, 0, 0],
		[1, 1, 1],
		[0, 0, 0],
	],
	[
		[0, 0, 0],
		[0, 1, 0],
		[0, 0, 0],
	],
	[
		[0, 0, 0],
		[0, 1, 0],
		[0, 0, 0],
	],
]

const BLUE = Color("#40B2FF")
const YELLOW = Color("#EBD45B")
const PURPLE = Color("#D87DFF")
const GREEN = Color("#54CC5F")
const ORANGE = Color("#FF8359")

var colours = [
	BLUE,
	YELLOW,
	PURPLE,
	GREEN,
	ORANGE
]

func _ready():
	randomize()
	var new_material = SpatialMaterial.new()
	new_material.albedo_color = colours[randi() % colours.size()]
	
	for y in range(3):
		for x in range(3):
			for z in range(3):
				if t_shape[y][x][z] == 1:
					var new_cube: MeshInstance = cube.instance().get_child(0)
					new_cube.translate(Vector3(x, y, z))
					new_cube.mesh.surface_set_material(0, new_material)
					add_child(new_cube.get_parent())

func _process(delta):
	pass
