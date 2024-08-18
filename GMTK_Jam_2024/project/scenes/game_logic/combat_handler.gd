extends Node
class_name CombatHandler

@onready var current_round: int = 1
@onready var current_subround: int = 1
@onready var current_options: Array[ShifumiOption] = []
@onready var remaining_options: Array[ShifumiOption] = []

@onready var p1_option_history: Array[ShifumiOption] = []
@onready var p2_option_history: Array[ShifumiOption] = []

@onready var p1_score: int = 0
@onready var p2_score: int = 0

@export var drawquote_template = "%s Versus %s ! Ohhh, It's a draw !"
@export var winquote_template = "%s %s %s ! It's a win for %s !"
@export var bugquote_template = "This one was for nothing, let's try again !"

signal trigger_new_round()

# Called when the node enters the scene tree for the first time.
func _ready():
	load_all_options()
	set_big_three_to_current()

func load_all_options() -> void:
	for option: ShifumiOption in get_children():
		remaining_options.append(option)
	remaining_options.reverse()

# Used to always have rock paper scissors at the begining of a game
func set_big_three_to_current() -> void:
	for option: ShifumiOption in remaining_options:
		if option.name == "Rock" or option.name == "Paper" or option.name == "Scissors":
			current_options.append(remaining_options.pop_at(remaining_options.find(option)))


func get_options() -> Array[String]:
	var string_options: Array[String] = []
	for option: ShifumiOption in current_options:
		string_options.append(option.name)
	string_options.shuffle()
	return string_options


func add_option_for_round():
	remaining_options.shuffle()
	for n in range(0, current_round):
		if remaining_options.is_empty():
			return
		current_options.append(remaining_options.pop_at(remaining_options.find(remaining_options.pick_random())))


func resolve_fight(player_option_name: String) -> Array[String]:
	var p1_play: ShifumiOption
	for option: ShifumiOption in current_options:
		if option.name == player_option_name:
			p1_play = option
	p1_option_history.push_back(p1_play)
	var p2_play: ShifumiOption = pick_cpu_option()
	p2_option_history.push_back(p2_play)
	# Same play
	if p1_play.name == p2_play.name:
		return [drawquote_template % [p1_play.name, p2_play.name], p1_play.name, p2_play.name]
	for p1_beat: ShifumiBeatenOption in p1_play.get_children():
		if p1_beat.name == p2_play.name:
			p1_play.unlock_relation(p1_beat)
			p1_score += 1
			return [winquote_template % [p1_play.name, p1_play.get_win_quote(p2_play.name), p2_play.name, "you"], p1_play.name, p2_play.name]
	for p2_beat: ShifumiBeatenOption in p2_play.get_children():
		if p2_beat.name == p1_play.name:
			p2_play.unlock_relation(p2_beat)
			p2_score += 1
			return [winquote_template % [p2_play.name, p2_play.get_win_quote(p1_play.name), p1_play.name, "CPU"], p1_play.name, p2_play.name]
	return [bugquote_template, p1_play.name, p2_play.name]


func pick_cpu_option() -> ShifumiOption:
	var opt = current_options.pick_random()
	while opt == get_last_played_p2_option():
		opt = current_options.pick_random()
	return opt


func get_wins_for(option_name: String) -> Array[String]:
	var wins: Array[String]
	for option: ShifumiOption in current_options:
		if option.name == option_name:
			for beaten_option: ShifumiBeatenOption in option.get_children():
				if beaten_option.unlocked_result:
					wins.append(beaten_option.name)
	return wins


func get_last_played_p1_option() -> ShifumiOption:
	if p1_option_history.size() > 0:
		return p1_option_history[-1]
	return null


func get_last_played_p1_option_name() -> String:
	if p1_option_history.size() > 0:
		return p1_option_history[-1].name
	return ""


func get_last_played_p2_option() -> ShifumiOption:
	if p2_option_history.size() > 0:
		return p2_option_history[-1]
	return null


func get_last_played_p2_option_name() -> String:
	if p2_option_history.size() > 0:
		return p2_option_history[-1].name
	return ""


func increment_round():
	current_round += 1
	current_subround = 1
	add_option_for_round()
	

func increment_subround():
	current_subround += 1


func next() -> void:
	if current_subround == 3:
		increment_round()
	else:
		increment_subround()
	trigger_new_round.emit()
