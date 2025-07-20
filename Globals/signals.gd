extends Node
# Global Name: Signals

signal object_interacted
signal player_moved
signal progress_changed

func _ready():
	object_interacted.connect(_on_object_interacted)
	player_moved.connect(_on_player_moved)
	progress_changed.connect(_on_progress_changed)

func _on_object_interacted(object_name):
	if OS.is_debug_build():
		print("SignalBus: interacted with %s" % [object_name])

func _on_player_moved(grid_pos):
	if OS.is_debug_build():
		print("SignalBus: Player moved to %s" % [grid_pos])

func _on_progress_changed(flag_name, value):
	if OS.is_debug_build():
		print("SignalBus: %s has been set to %s." % [flag_name, value])
