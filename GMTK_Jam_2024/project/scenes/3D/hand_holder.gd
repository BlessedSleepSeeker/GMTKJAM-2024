extends Node3D

@export var name_convention_hand: String = "Hand%s"

func hide_all() -> void:
	for hand in get_children():
		hand.hide()

func show_hand(sign_name: String) -> void:
	print_debug(name_convention_hand % sign_name)
	for hand in get_children():
		if hand.name == name_convention_hand % sign_name:
			hand.show()