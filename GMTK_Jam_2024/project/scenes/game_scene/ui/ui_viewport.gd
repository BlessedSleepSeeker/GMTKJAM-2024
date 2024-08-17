extends SubViewportContainer
class_name UiViewport

@export var option_button_scene: PackedScene = preload("res://scenes/game_scene/ui/choice_buttons/shifumi_option_button.tscn")
@onready var turn_counter = $SubViewport/MarginContainer/Turns/HBoxContainer/Turn_counter
@onready var round_counter = $SubViewport/MarginContainer/Turns/HBoxContainer2/Round_counter
@onready var button_path = $SubViewport/CenterContainer/Control/ButtonPath

signal i_need_win_for(option: String)

func create_option(name: String) -> void:
	print(name)
	
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
		i_need_win_for.emit(option_button.option_name)
	else:
		option_button.line_toggle(toggled, [])

func send_win_info(opt_name: String, win_info: Array[String]):
	var win_pos: Array[Vector2] = []
	for opt_btn: ShifumiOptionButton in button_path.get_children():
		for win_opt: String in win_info:
			if win_opt == opt_btn.option_name:
				win_pos.append(Vector2(opt_btn.global_position))
	for opt_btn: ShifumiOptionButton in button_path.get_children():
		if opt_btn.option_name == opt_name:
			opt_btn.line_toggle(true, win_pos)

func _process(_delta):
	for opt_btn: ShifumiOptionButton in button_path.get_children():
		if opt_btn.button.button_pressed:
			i_need_win_for.emit(opt_btn.option_name)
