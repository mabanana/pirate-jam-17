extends Control
class_name ReadingController

enum Read {
	AUG_1,
	AUG_ANG_TRANSCRIPT,
	VIN_1,
	VIN_DISMISSAL,
	ORL_1,
	ORL_RECORD,
	HAR_COMP,
	ANG_COMP,
	AUG_COMP,
	PRIZE_OF_CIV,
	VIN_COMP,
	VIN_FULL_DISMISSAL,
	HAR_FULL_DISMISSAL,
	OR_COMP,
	WARDEN_RECC,
}

func _ready():
	Signals.reading_started.connect(start_read)

func start_read(read_string: String):
	var read: Read
	if read_string.to_upper() in Read.keys():
		read = Read.keys().find(read_string.to_upper())
	print("Started reading %s" % Read.keys()[read])
	pass

func end_read():
	pass
