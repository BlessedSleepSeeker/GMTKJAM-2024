extends Node

@onready var combat_handler: CombatHandler = null
@onready var ui: UiViewport = find_child('UI')

@onready var turn_counter: Label = ui.turn_counter
@onready var round_counter: Label = ui.round_counter
@onready var score_counter: Label = ui.score_counter
@onready var cpu_score_counter: Label = ui.cpu_score_counter

var current_options: Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	combat_handler = find_child('CombatHandler')
	update_score()
	start_turn()
	
func start_turn() -> void:
	current_options = combat_handler.get_options()
	update_turns()
	update_rounds()
	for option: String in current_options:
		ui.create_option(option)

func update_turns() -> void:
	turn_counter.set_text(str(combat_handler.current_round))

func update_rounds() -> void:
	round_counter.set_text(str(combat_handler.current_subround))

func update_score() -> void:
	score_counter.set_text(str(combat_handler.p1_score))
	cpu_score_counter.set_text(str(combat_handler.p2_score))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
