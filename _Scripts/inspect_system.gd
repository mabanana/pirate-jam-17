extends Node3D

@export var inspect_camera: Camera3D
@export var inspect_position: Node3D

var original_camera: Camera3D
var inspected_object: Node3D
var original_transform: Transform3D
var original_parent: Node
var is_inspecting: bool = false

func _ready():
	process_priority = 10

func is_currently_inspecting() -> bool:
	return is_inspecting

func try_inspect_object(object_name: String) -> bool:
	# Find object anywhere in scene
	var obj = get_tree().current_scene.find_child(object_name, true, false)
	if not obj or not obj.has_meta("inspectable"):
		return false
	
	# Start inspection
	is_inspecting = true
	inspected_object = obj
	original_transform = obj.global_transform
	original_parent = obj.get_parent()
	original_camera = get_viewport().get_camera_3d()
	
	obj.reparent(inspect_position)
	obj.transform = Transform3D.IDENTITY
	
	original_camera.current = false
	inspect_camera.current = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	return true

func stop_inspection():
	inspected_object.reparent(original_parent)
	inspected_object.global_transform = original_transform
	
	inspect_camera.current = false
	original_camera.current = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	is_inspecting = false

func _input(event):
	if not is_inspecting:
		return
	
	get_viewport().set_input_as_handled()
	
	# Exit on any click or escape
	if (event.is_action_pressed("ui_cancel") 
		or (event is InputEventMouseButton and event.pressed)):
		stop_inspection()
		return
	
	# Rotate with mouse
	if event is InputEventMouseMotion:
		inspected_object.rotate_y(-event.relative.x * 0.005)
		inspected_object.rotate_object_local(Vector3.RIGHT, -event.relative.y * 0.005)
