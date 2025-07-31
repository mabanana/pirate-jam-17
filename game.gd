extends Node3D
class_name Game

@export var main_menu: MainMenu
var game

# Called when the node enters the scene tree for the first time.
func _ready():
	child_entered_tree.connect(func(node):
		if node.name == "Room":
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	)
	child_exiting_tree.connect(func(node):
		if node.name == "Room":
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if game:
			main_menu.visible = !main_menu.visible
			Signals.in_menu = main_menu.visible
			if main_menu.visible:
				Signals.game_paused.emit()
			else:
				Signals.game_unpaused.emit()

func start_game():
	game = load("res://Room/room.tscn").instantiate()
	add_child(game)
