extends Node3D
class_name Shaders

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is MeshInstance3D:
			ShaderManager.add_outline(child)
	
	await get_tree().create_timer(2).timeout.connect
	for child in get_children():
		if child is MeshInstance3D:
			ShaderManager.remove_outline(child)
	
	await get_tree().create_timer(2).timeout.connect
	for child in get_children():
		if child is MeshInstance3D:
			ShaderManager.add_outline(child)
