extends Control
class_name MainMenu

@export var game: Game

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Start.pressed.connect(func():
		game.start_game()
		move_to_front()
		hide())
	$VBoxContainer/Quit.pressed.connect(func():
		get_tree().quit())
	$VBoxContainer/Resume.pressed.connect(func():
		hide())
	$VBoxContainer/Return.pressed.connect(func():
		game.game.queue_free())

func _process(delta):
	if game.game:
		$VBoxContainer/Resume.show()
		$VBoxContainer/Return.show()
		$VBoxContainer/Start.hide()
	else:
		$VBoxContainer/Resume.hide()
		$VBoxContainer/Return.hide()
		$VBoxContainer/Start.show()
