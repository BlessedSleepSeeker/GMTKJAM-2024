extends Node

@onready var combat_handler: CombatHandler = $CombatHandler
@onready var ui: UiViewport = $UiViewport
@onready var world_controller: Node3D = $World
@onready var fader: AnimationPlayer = $Fader

@onready var turn_counter: Label = ui.turn_counter
@onready var round_counter: Label = ui.round_counter
@onready var score_counter: Label = ui.score_counter
@onready var cpu_score_counter: Label = ui.cpu_score_counter
@onready var win_phrase_container: Panel = ui.win_phrase_container
@onready var win_phrase: Label = ui.win_phrase


var current_options: Array[String] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	world_controller.hide_hands()
	ui.hide()
	ui.i_need_win_for.connect(get_wins)
	ui.player_choice.connect(process_round)
	world_controller.play_intro()
	await world_controller.intro_finished
	start_turn()
	fader.play("ui_fade_in")
	#needed to avoid frame desync showing UI before fade in
	await get_tree().create_timer(0.002).timeout
	ui.show()

func start_turn() -> void:
	world_controller.hide_hands()
	current_options = combat_handler.get_options()
	update_score()
	update_turns()
	update_rounds()
	ui.round_scalling_update(combat_handler.current_round, combat_handler.current_subround)
	var p1_disabled_opt: String = combat_handler.get_last_played_p1_option_name()
	var p2_disabled_opt: String = combat_handler.get_last_played_p2_option_name()
	for option_name: String in current_options:
		if option_name == p1_disabled_opt:
			ui.create_option(option_name, true, true)
		elif option_name == p2_disabled_opt:
			ui.create_option(option_name, true, false)
		else:
			ui.create_option(option_name, false, false)
	

func process_round(option: String) -> void:
	fader.play("ui_fade_out")
	var combat_result = combat_handler.resolve_fight(option)
	win_phrase.set_text(combat_result[0])
	await fader.animation_finished
	world_controller.play_fight(combat_result[1], combat_result[2], combat_handler.get_options())
	await world_controller.fight_finished
	fader.play("ui_fade_in")
	await fader.animation_finished
	win_phrase_container.visible = true
	await get_tree().create_timer(2.5).timeout
	win_phrase_container.visible = false
	combat_handler.next()

func get_wins(option: String) -> void:
	ui.send_win_info(option, combat_handler.get_wins_for(option))


func update_turns() -> void:
	turn_counter.set_text(str(combat_handler.current_round))


func update_rounds() -> void:
	round_counter.set_text(str(combat_handler.current_subround))


func update_score() -> void:
	score_counter.set_text(str(combat_handler.p1_score))
	cpu_score_counter.set_text(str(combat_handler.p2_score))


func _on_combat_handler_trigger_new_round() -> void:
	start_turn()