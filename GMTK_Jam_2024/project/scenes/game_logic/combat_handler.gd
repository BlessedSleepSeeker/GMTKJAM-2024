extends Node
class_name CombatHandler

@onready var current_round: int = 1
@onready var current_subround: int = 1
@onready var current_options: Array[Node] = []
@onready var remaining_options: Array[Node] = []

@onready var p1_score: int = 0
@onready var p2_score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	load_all_options()
	set_big_three_to_current()
	for i in range(0, 6):
		for j in range(0, 3):
			print_debug(resolve_fight(get_options().pick_random()))
		increment_round()


func load_all_options() -> void:
	for option: Node in get_children():
		remaining_options.append(option)
	remaining_options.reverse()
	

func set_big_three_to_current() -> void:
	for option: Node in remaining_options:
		if option.name == "Rock" or option.name == "Paper" or option.name == "Scissors":
			current_options.append(remaining_options.pop_at(remaining_options.find(option)))


func get_options() -> Array[String]:
	var string_options: Array[String] = []
	for option: Node in current_options:
		string_options.append(option.name)
	return string_options


func increment_round():
	current_round += 1
	add_option_for_round()


func add_option_for_round():
	remaining_options.shuffle()
	for n in range(0, current_round):
		if remaining_options.is_empty():
			return
		current_options.append(remaining_options.pop_at(remaining_options.find(remaining_options.pick_random())))


func resolve_fight(player_option_name: String) -> String:
	var p1_play: Node
	for option: Node in current_options:
		if option.name == player_option_name:
			p1_play = option
	var p2_play: Node = pick_cpu_option()
	print_debug("%s versus %s" % [p1_play.name, p2_play.name])
	# Same play
	if p1_play.name == p2_play.name:
		return "It's a draw"
	# P1 win.
	# TODO : replace P1 win and P2 win by the correct quote.
	for p1_beat: Node in p1_play.get_children():
		if p1_beat.name == p2_play.name:
			return "P1 win ! %s beat %s" % [p1_play.name, p2_play.name]
	for p2_beat: Node in p2_play.get_children():
		if p2_beat.name == p1_play.name:
			return "P2 win ! %s beat %s" % [p2_play.name, p1_play.name]
	return "This one didn't count..."



func pick_cpu_option() -> Node:
	return current_options.pick_random()