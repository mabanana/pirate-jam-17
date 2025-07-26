extends Node3D
class_name Shaders

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is MeshInstance3D:
			add_outline(child)
	
	await get_tree().create_timer(2).timeout.connect
	for child in get_children():
		if child is MeshInstance3D:
			remove_outline(child)
	
	await get_tree().create_timer(2).timeout.connect
	for child in get_children():
		if child is MeshInstance3D:
			add_outline(child)

static func add_outline(node: MeshInstance3D):
	for child in node.get_children():
		if child is OutlineMesh:
			child.show()
			return
	var outline = OutlineMesh.new()
	outline.mesh_instance = node
	node.add_child(outline)

static func remove_outline(node: MeshInstance3D):
	for child in node.get_children():
		if child is OutlineMesh:
			child.hide()
