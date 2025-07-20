extends Node3D

@export var camera : Camera3D
func _input(event: InputEvent):
	if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		var mouse_pos = event.position
		var from = camera.project_ray_origin(mouse_pos)
		var to = from + camera.project_ray_normal(mouse_pos) * 1000
		var space_state = get_world_3d().direct_space_state
		var result = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(from,to))
		if  result:
			var clicked_object = result.collider
			var objectname = clicked_object.get_groups()
			print(objectname)
