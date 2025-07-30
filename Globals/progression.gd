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
	var value_changed = false
	if value != get(flag_name):
		Signals.progress_changed.emit(flag_name, value)
		value_changed = true
	set(flag_name, value)
	
	check_progress(flag_name, value)
	return value_changed

func check_progress(flag_name, value):
	if august_read and vince_read and orlando_read and flag_name in ["august_read", "vince_read", "orlando_read"] and value:
		files_checked = true
		can_computer = true
		can_phone = true
	if "coffee_made" == flag_name and value:
		coffee_drank = true
	if flag_name == "coffee_drank" and value:
		can_desk = true
		Signals.music_change_started.emit(AudioController.Audio.SMOKE_AND_MIRRORS_3)

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
		"ComputerDesk":
			if can_desk:
				set_flag("ComputerDesk", true)
				Signals.music_change_started.emit(AudioController.Audio.PYRAMIDS_V9)
		"Computer":
			if can_computer:
				set_flag("Computer", true)
		"Phonebook":
			set_flag("Phonebook", true)
		
	Dialogic.VAR.Object = str(object.name)
	Dialogic.start("exploration")
	
