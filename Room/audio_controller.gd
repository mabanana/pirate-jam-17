extends Node
class_name AudioController

@export var music_player: AudioStreamPlayer
@export var sfx_player: AudioStreamPlayer3D
@export var notif_player: AudioStreamPlayer

enum Audio {
	NEW_DAY_TRIGGER,
	NOISE_AMBIENT,
	PYRAMIDS_V9,
	RED_HERRING,
	SMOKE_AND_MIRRORS_3,
}

var music_paths = {
	Audio.NEW_DAY_TRIGGER: "res://Assets/Audio/Effects/new day trigger.wav",
	Audio.NOISE_AMBIENT: "res://Assets/Audio/Effects/noise ambient.wav",
	Audio.PYRAMIDS_V9: "res://Assets/Audio/Music/Pyramidsv9.wav",
	Audio.RED_HERRING: "res://Assets/Audio/Music/Red Herring.wav",
	Audio.SMOKE_AND_MIRRORS_3: "res://Assets/Audio/Music/smoke and mirrors 3.wav",
}

func _ready():
	music_player.finished.connect(transition_music.bind(Audio.NOISE_AMBIENT))
	Signals.sfx_started.connect(play_sfx)
	Signals.music_change_started.connect(transition_music)

func transition_music(audio: Audio):
	var audio_resource = load(music_paths[audio])
	if music_player.playing:
		var tween := get_tree().create_tween()
		tween.tween_property(music_player, "volume_db", -16, 5.0)
		tween.play()
		await tween.finished
	music_player.stream = audio_resource
	var tween := get_tree().create_tween()
	tween.tween_property(music_player, "volume_db", 0.0, 8.0)
	tween.play()
	music_player.play()
	print("Now playing track %s" % [Audio.keys()[audio]])

func play_sfx(audio: Audio, pos: Vector3):
	var audio_resource = load(music_paths[audio])
	sfx_player.position = pos
	sfx_player.stream = audio_resource
	sfx_player.play()
	print("sfx played %s" % [Audio.keys()[audio]])
