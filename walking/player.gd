extends Node3D

var player_move_requested = Signals.player_move_requested
var player_move_resolved = Signals.player_move_resolved
var player_rotated = Signals.player_rotated

@export var facing = 2

var facings = [
	[-1,0,0],
	[0,0,-1],
	[1,0,0],
	[0,0,1]]
var facing_basis = [
	Basis(Vector3(1.0, 0.0, 0.0), Vector3(0.0, 1.0, 0.0), Vector3(0.0, 0.0, 1.0)),
	Basis(Vector3(-0.0, 0.0, 1.0), Vector3(0.0, 1.0, 0.0), Vector3(-1.0, 0.0, -0.0)),
	Basis(Vector3(-1.0, 0.0, -0.0), Vector3(0.0, 1.0, 0.0), Vector3(0.0, 0.0, -1.0)),
	Basis(Vector3(0.0, 0.0, -1.0), Vector3(0.0, 1.0, 0.0), Vector3(1.0, 0.0, 0.0))]

# Called when the node enters the scene tree for the first time.
func _ready():
	transform = Transform3D(facing_basis[facing%len(facings)], position)
	player_move_resolved.connect(move_tween)

func _input(event):
	if event.is_action_pressed("ui_left"):
		facing -= 1
		rotate_tween()
	elif event.is_action_pressed("ui_right"):
		facing += 1
		rotate_tween()
	elif event.is_action_pressed("ui_up"):
		player_move_requested.emit(facings[facing % len(facings)])
	elif event.is_action_pressed("ui_down"):
		player_move_requested.emit(facings[(facing + 2) % len(facings)])

func rotate_tween():
	player_rotated.emit(facing)
	var tween:= get_tree().create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "transform", Transform3D(facing_basis[facing%len(facings)], position), 0.6)
	
	tween.play()
	return tween.finished

func move_tween(dest):
	var tween:= get_tree().create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "position", dest, 0.6)
	
	tween.play()
	return tween.finished
