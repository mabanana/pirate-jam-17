extends Node
# Global Name: Progress

# Prototype
var door_interacted: bool = false
var drawer_interacted: bool = false
var tv_interacted: bool = false

# Day 1
var coffee_made: bool = false
var coffee_drank: bool = false
var medication_interacted: bool = false
var blood_interacted: bool = false
var apology_letter_interacted: bool = false
var files_checked: bool = false
var august_read: bool = false
var vince_read: bool = false
var orlando_read: bool = false

var can_computer: bool = false
var can_phone: bool = false
var can_desk: bool = false

# Day 2

# Day 3


func _ready():
	Signals.object_interacted.connect(_on_object_interacted)

func set_flag(flag_name, value = true):
	if value != get(flag_name):
		Signals.progress_changed.emit(flag_name, value)
	set(flag_name, value)
	
	check_progress(flag_name, value)

func check_progress(flag_name, value):
	if august_read and vince_read and orlando_read:
		files_checked = true
	if coffee_made:
		coffee_drank = true
	if coffee_drank:
		can_desk = true

func _on_object_interacted(object):
	match object.name:
		"Television":
			set_flag("tv_interacted", true)
		"Drawer":
			set_flag("drawer_interacted", true)
		"Door":
			set_flag("door_interacted", true)
		"Medication":
			set_flag("medication_interacted", true)
		"InstantCoffee":
			set_flag("coffee_made", true)
		"LukewarmCoffee":
			set_flag("coffee_drank", true)
		"Blood":
			set_flag("blood_interacted", true)
		"LetterOfApology":
			set_flag("apology_letter_interacted", true)
		
	Dialogic.VAR.Object = str(object.name)
	Dialogic.start("exploration")
	
