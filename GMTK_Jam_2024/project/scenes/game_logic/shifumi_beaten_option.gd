extends Node
class_name ShifumiBeatenOption

@export var reasons: Array[String] = []
@export var unlocked_result: bool = false

func get_win_quote():
	return reasons.pick_random()