extends CanvasLayer
class_name UiViewport

@export var option_button_scene: PackedScene = preload("res://scenes/game_scene/ui/choice_buttons/shifumi_option_button.tscn")

@onready var turn_counter = $MarginContainer/Turns/HBoxContainer/Turn_counter
@onready var round_counter = $MarginContainer/Turns/HBoxContainer2/Round_counter
@onready var score_counter = $MarginContainer/Score/HBoxContainer/Score_counter
@onready var cpu_score_counter = $MarginContainer/Score/HBoxContainer2/Cpu_score_counter
@onready var win_phrase = $CenterContainer/WinPhraseContainer/CenterContainer/MarginContainer/WinPhrase
@onready var win_phrase_container = $CenterContainer/WinPhraseContainer
@onready var button_path = $CenterContainer/Control/ButtonPath
@onready var validate_button = $CenterContainer/ValidateButton

var toggled_options: Array[String] = []

signal i_need_win_for(option: String)
signal player_choice(option: String)

func create_option(name: String) -> void:
	var option = option_button_scene.instantiate()
	option.play_button_toggled.connect(_on_option_button_toggled)
	option.option_name = name
	button_path.add_child(option)
	
	var length = button_path.curve.get_baked_length()
	var total_childs = button_path.get_child_count()
	var unit = length / total_childs
	var i = 0
	
	for child: PathFollow2D in button_path.get_children():
		child.progress = unit * i
		i += 1

func _on_option_button_toggled(toggled: bool, option_button: ShifumiOptionButton):
	if toggled:
		if option_button.option_name not in toggled_options:
			toggled_options.push_back(option_button.option_name)
		i_need_win_for.emit(option_button.option_name)
	else:
		if option_button.option_name in toggled_options:
			toggled_options.remove_at(toggled_options.find(option_button.option_name))
		option_button.line_toggle(toggled, [])
	check_validation_button_status()

func send_win_info(opt_name: String, win_info: Array[String]):
	var win_pos: Array[Vector2] = []
	for opt_btn: ShifumiOptionButton in button_path.get_children():
		for win_opt: String in win_info:
			if win_opt == opt_btn.option_name:
				win_pos.append(Vector2(opt_btn.global_position))
	for opt_btn: ShifumiOptionButton in button_path.get_children():
		if opt_btn.option_name == opt_name:
			opt_btn.line_toggle(true, win_pos)

func check_validation_button_status() -> void:
	if toggled_options.size() == 0:
		validate_button.visible = false
	elif validate_button.visible == false:
		validate_button.visible = true
		
	if toggled_options.size() > 1:
		validate_button.disabled = true
		validate_button.tooltip_text = 'Please choose a single action'
	elif validate_button.disabled == true:
		validate_button.disabled = false
		validate_button.tooltip_text = ''

func _on_validate_button_pressed() -> void:
	var selected_option = toggled_options[0]
	for child: PathFollow2D in button_path.get_children():
		button_path.remove_child(child)
	validate_button.tooltip_text = ''
	validate_button.visible = false
	toggled_options = []
	player_choice.emit(selected_option)

func _process(_delta):
	for opt_btn: ShifumiOptionButton in button_path.get_children():
		if opt_btn.button.button_pressed:
			i_need_win_for.emit(opt_btn.option_name)
