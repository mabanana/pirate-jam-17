extends Node
# Global Name: Progress

var door_interacted: bool = false
var drawer_interacted: bool = false
var tv_interacted: bool = false

func _ready():
	Signals.object_interacted.connect(_on_object_interacted)

func set_flag(flag_name, value = true):
	if value != get(flag_name):
		Signals.progress_changed.emit(flag_name, value)
	set(flag_name, value)
	
	check_progress(flag_name, value)

func check_progress(flag_name, value):
	if (door_interacted 
	and drawer_interacted 
	and tv_interacted 
	and value
	and flag_name in ["door_interacted", "drawer_interacted", "tv_interacted"]):
		if OS.is_debug_build():
			print("you've interacted with everything")

func _on_object_interacted(object_name):
	if object_name == "Television":
		set_flag("tv_interacted", true)
	elif object_name == "Drawer":
		set_flag("drawer_interacted", true)
	elif object_name == "Door":
		set_flag("door_interacted", true)
