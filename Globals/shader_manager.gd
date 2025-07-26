extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_signals()

func connect_signals():
	Signals.object_hover_entered.connect(add_outline)
	Signals.object_hover_exited.connect(remove_outline)

func add_outline(node: Node3D):
	var mesh_instance
	for child in [node] + node.get_children():
		if child is MeshInstance3D:
			mesh_instance = child 
			break
	
	for child in mesh_instance.get_children():
		if child is OutlineMesh:
			child.show()
			return
	var outline = OutlineMesh.new()
	outline.mesh_instance = mesh_instance
	mesh_instance.add_child(outline)

func remove_outline(node: Node3D):
	var mesh_instance
	for child in [node] + node.get_children():
		if child is MeshInstance3D:
			mesh_instance = child
			break
			
	for child in mesh_instance.get_children():
		if child is OutlineMesh:
			child.hide()
