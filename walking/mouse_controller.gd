extends Node

@export var ray_length = 1.2
@export var camera: Camera3D
@export var cursor: Control

var focus: Node3D

var object_hover_entered = Signals.object_hover_entered
var object_hover_exited = Signals.object_hover_exited

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
			object_hover_entered.emit(focus.name)
			cursor.label.text = focus.name
			cursor.label.visible = true
			cursor.cursor.visible = false
			
	else:
		if focus:
			object_hover_exited.emit(focus.name)
		focus = null
		cursor.label.visible = false
		cursor.cursor.visible = true

func _input(event):
	if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		if focus:
			Signals.object_interacted.emit(focus.name)
			Dialogic.VAR.Object = str(focus.name)
			Dialogic.start("test_timeline")
