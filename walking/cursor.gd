extends Control

@export var label: Label
@export var cursor: Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.timeline_started.connect(hide)
	Dialogic.timeline_ended.connect(show)
	Dialogic.state_changed.connect(func(state):
		if state == Dialogic.States.AWAITING_CHOICE:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_viewport().get_mouse_position()
