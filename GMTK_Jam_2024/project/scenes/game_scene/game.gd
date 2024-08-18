extends Node

@onready var combat_handler: CombatHandler = $CombatHandler
@onready var ui: UiViewport = $UiViewport

@onready var turn_counter: Label = ui.turn_counter
@onready var round_counter: Label = ui.round_counter
@onready var score_counter: Label = ui.score_counter
@onready var cpu_score_counter: Label = ui.cpu_score_counter
@onready var win_phrase_container: Panel = ui.win_phrase_container
@onready var win_phrase: Label = ui.win_phrase

var current_options: Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui.i_need_win_for.connect(get_wins)
	ui.player_choice.connect(process_round)
	start_turn()

func start_turn() -> void:
	current_options = combat_handler.get_options()
	update_score()
	update_turns()
	update_rounds()
	var p1_disabled_opt: String = combat_handler.get_last_played_p1_option_name()
	var p2_disabled_opt: String = combat_handler.get_last_played_p2_option_name()
	print_debug(p2_disabled_opt)
	for option_name: String in current_options:
		if option_name == p1_disabled_opt:
			ui.create_option(option_name, true, true)
		elif option_name == p2_disabled_opt:
			ui.create_option(option_name, true, false)
		else:
			ui.create_option(option_name, false, false)


func _on_combat_handler_trigger_new_round() -> void:
	start_turn()
	
func get_wins(option: String):
	ui.send_win_info(option, combat_handler.get_wins_for(option))

func process_round(option: String):
	var winphrase = combat_handler.resolve_fight(option)
	win_phrase.set_text(winphrase)
	win_phrase_container.visible = true
	await get_tree().create_timer(2.5).timeout
	win_phrase_container.visible = false
	combat_handler.next()

func update_turns() -> void:
	turn_counter.set_text(str(combat_handler.current_round))

func update_rounds() -> void:
	round_counter.set_text(str(combat_handler.current_subround))

func update_score() -> void:
	print(combat_handler.p1_score)
	print(combat_handler.p2_score)
	score_counter.set_text(str(combat_handler.p1_score))
	cpu_score_counter.set_text(str(combat_handler.p2_score))
