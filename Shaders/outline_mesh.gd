extends MeshInstance3D
class_name OutlineMesh

@export var mesh_instance: MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready():
	mesh = mesh_instance.mesh
	scale = mesh_instance.scale * 1.1
	for surface_idx in get_surface_override_material_count():
		set_surface_override_material(surface_idx, load("res://Shaders/outline_material.tres"))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mesh_instance.rotation += Vector3.ONE * delta
	
