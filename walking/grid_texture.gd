@tool
extends MeshInstance3D

func set_grid(uv_scale):
	mesh.material.set_shader_parameter("uv_scale", uv_scale)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
