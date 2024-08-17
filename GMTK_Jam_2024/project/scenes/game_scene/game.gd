extends Node

@onready var combat_handler: CombatHandler = null
@onready var ui: UiViewport = find_child('UI')
@onready var turn_counter: Label = ui.find_child('Turn_counter')
@onready var score_counter: Label = ui.find_child('Score_counter')

var current_options: Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	combat_handler = find_child('CombatHandler')
	current_options = combat_handler.get_options()
	start_turn()
	
func start_turn() -> void:
	current_options = combat_handler.get_options()
	turn_counter.set_text(str(combat_handler.current_round))
	for option: String in current_options:
		spawn_option(option)

func spawn_option(option: String) -> void:
	ui.create_option(option)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
