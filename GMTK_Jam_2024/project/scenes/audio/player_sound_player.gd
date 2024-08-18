extends AudioStreamPlayer

@export var voice_name: String = "1"
@export var sound_path_template: String = "res://assets/sounds/options/voice%d/%s.mp3"

func load_play_sound(option_name: String, speed: float):
	var sound: AudioStream = load(sound_path_template % [voice_name, option_name.to_lower()])
	stream = sound
	play()