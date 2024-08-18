extends Setting

@export var main_menu = preload("res://scenes/menu/main_menu.tscn")

signal transition(new_scene: PackedScene, animation: String)

func _ready():
	await get_tree().create_timer(2.5).timeout
	transition.emit(main_menu, "intro_transition")


func _input(event: InputEvent) -> void:
	if event is InputEventKey or event is InputEventMouseButton or event is InputEventJoypadButton:
		transition.emit(main_menu, "intro_transition")
