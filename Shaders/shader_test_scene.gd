extends Node3D
class_name Shaders

# Called when the node enters the scene tree for the first time.
func _ready():
	var node
	for child in get_children():
		if child is MeshInstance3D:
			node = child
	ShaderManager.add_outline(node)
	await get_tree().create_timer(2).timeout
	ShaderManager.remove_outline(node)
	await get_tree().create_timer(2).timeout
	ShaderManager.add_outline(node)
