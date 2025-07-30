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

func start_read(read: Read):
	pass

func end_read():
	pass
