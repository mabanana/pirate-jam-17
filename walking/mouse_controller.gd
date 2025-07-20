extends Node
@export var ray_length = 1.2
@export var camera: Camera3D
@export var cursor: Control
var focus: Node3D
var mouse_clicked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var space_state = camera.get_world_3d().direct_space_state
	var mousepos = camera.get_viewport().get_mouse_position()
	var origin = camera.project_ray_origin(mousepos)
	var end = origin + camera.project_ray_normal(mousepos) * ray_length
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	
	if result:
		if result["collider"] != focus:
			focus = result["collider"]
			print(focus.name)
			cursor.label.text = focus.name
			cursor.label.visible = true
			cursor.cursor.visible = false
	else:
		focus = null
		cursor.label.visible = false
	
	# Check for mouse click
	if Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if not mouse_clicked and result:
			mouse_clicked = true
			Dialogic.VAR.Object = str(focus.name)
			Dialogic.start("test_timeline")
	else:
		mouse_clicked = false
