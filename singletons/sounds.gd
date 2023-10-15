extends Node

const SOUND_FORMAT: String =  "wav"
const SOUND_DIR: String = "res://sounds"
var currently_playing: Array[AudioStreamPlayer]
var sounds: Dictionary

func _ready() -> void:
	find_sounds(SOUND_DIR)

func find_sounds(path: String) -> void:
	var dir: DirAccess = DirAccess.open(path)
	if dir:
		print_debug(dir)
		dir.list_dir_begin()
		var file_name: String = dir.get_next()
		while file_name != "":
			print_debug(file_name)
			if dir.current_is_dir():
				find_sounds(path + "/" + file_name)
			else:
				if file_name.ends_with("."+SOUND_FORMAT):
					var sound_path: String = path + "/" + file_name
					var audio_stream: AudioStream = load(sound_path)
					sounds[file_name.split(".")[0]] = audio_stream
			file_name = dir.get_next()
	else:
		print_debug("Failed to open directory!")


func play_sound(sound_name: String, volume_db: float = 1.0) -> void:
	var new_player: AudioStreamPlayer = AudioStreamPlayer.new()
	new_player.volume_db = volume_db
	add_child(new_player)
	var stream: AudioStream = sounds[sound_name]
	new_player.stream = stream
	new_player.play()
	currently_playing.push_back(new_player)
	new_player.finished.connect(_player_finished.bind(new_player))

func _player_finished(player: AudioStreamPlayer) -> void:
	currently_playing.erase(player)
	player.queue_free()
