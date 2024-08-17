extends SubViewportContainer
class_name UiViewport

@export var option_button: PackedScene
@onready var turn_counter = $SubViewport/MarginContainer/Turns/HBoxContainer/Turn_counter
@onready var round_counter = $SubViewport/MarginContainer/Turns/HBoxContainer2/Round_counter


func create_option(name: String) -> void:
	print(name)
	var button_path = find_child('ButtonPath')
	var option = option_button.instantiate()
	option.option_name = name
	button_path.add_child(option)
	
	var length = button_path.curve.get_baked_length()
	var total_childs = button_path.get_child_count()
	var unit = length / total_childs
	var i = 0
	
	for child: PathFollow2D in button_path.get_children():
		child.progress = unit * i
		i += 1
