extends Node

@onready var combat_handler: CombatHandler = null
@onready var ui: UiViewport = find_child('UI')
@onready var turn_counter: Label = ui.turn_counter
@onready var round_counter: Label = ui.round_counter
@onready var score_counter: Label = ui.find_child('Score_counter')

var current_options: Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	combat_handler = find_child('CombatHandler')
	start_turn()
	
func start_turn() -> void:
	current_options = combat_handler.get_options()
	print(combat_handler.current_round)
	print(combat_handler.current_subround)
	turn_counter.set_text(str(combat_handler.current_round))
	round_counter.set_text(str(combat_handler.current_subround))
	for option: String in current_options:
		ui.create_option(option)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
