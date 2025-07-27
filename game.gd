extends Node3D
class_name Game

@export var main_menu: MainMenu
var game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if game:
			main_menu.visible = !main_menu.visible

func start_game():
	game = load("res://Room/room.tscn").instantiate()
	add_child(game)
