extends Node
# Global Name: Signals

signal object_interacted
signal object_hover_entered
signal object_hover_exited
signal player_move_resolved
signal player_move_requested
signal player_rotated
signal progress_changed

func _ready():
	object_interacted.connect(_on_object_interacted)
	object_hover_entered.connect(_on_object_hover_entered)
	object_hover_exited.connect(_on_object_hover_exited)
	player_move_requested.connect(_on_player_move_requested)
	player_move_resolved.connect(_on_player_move_resolved)
	player_rotated.connect(_on_player_rotated)
	progress_changed.connect(_on_progress_changed)
	

func _on_object_interacted(object_name):
	if OS.is_debug_build():
		print("SignalBus: Player interacted with %s" % [object_name])

func _on_object_hover_entered(object_name: String):
	if OS.is_debug_build():
		print("SignalBus: Mouse hovered over %s." % object_name)

func _on_object_hover_exited(object_name: String):
	if OS.is_debug_build():
		print("SignalBus: Mouse removed from %s." % [object_name])

func _on_player_move_requested(move_vector: Vector3):
	if OS.is_debug_build():
		print("SignalBus: Player movement request xyz: %s" % [move_vector])
		
func _on_player_move_resolved(grid_pos):
	if OS.is_debug_build():
		print("SignalBus: Player moved to %s" % [grid_pos])

func _on_player_rotated(facing):
	if OS.is_debug_build():
		print("SignalBus: Player now facing %s" % [facing])

func _on_progress_changed(flag_name: String, value: bool):
	if OS.is_debug_build():
		print("SignalBus: %s has been set to %s." % [flag_name, value])
