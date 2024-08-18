extends AudioStreamPlayer
class_name RandomStreamPlayer

## Array storing all the playable sound streams.
@export var streams: Array[AudioStream] = []

## If no re_repeat is true, the same stream will not be played twice.
@export var no_repeat: bool = true

func play_random(from_position: float = 0.0) -> void:
	pick_random_stream()
	play(from_position)


func pick_random_stream() -> void:
	var picked_stream = streams.pick_random()
	if no_repeat and picked_stream == stream:
		# if we picked the same stream that was played, pick again
		return pick_random_stream()
	stream = picked_stream