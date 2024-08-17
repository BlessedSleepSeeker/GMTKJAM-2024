extends Node

@onready var combat_handler: CombatHandler = null
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
	combat_handler = find_child('CombatHandler')
	ui.i_need_win_for.connect(get_wins)
	ui.player_choice.connect(process_round)
	start_turn()

func start_turn() -> void:
	current_options = combat_handler.get_options()
	update_score()
	update_turns()
	update_rounds()
	for option_name: String in current_options:
		ui.create_option(option_name)

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
