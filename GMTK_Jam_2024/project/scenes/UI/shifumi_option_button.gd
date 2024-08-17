
@tool
extends PathFollow2D

@export var option_name: String = "Rock"
@export var icons_path_template: String = "res://assets/openmoji/%s.png"
@onready var icon_filepath: String = icons_path_template % option_name
@onready var button = $Button
@onready var lineHolder = $LineHolder
@onready var winLineScene = preload("res://scenes/UI/win_against_line.tscn")

var endPosForLine = [Vector2(100, 100), Vector2(42, 562), Vector2(-241, -279)]

# Called when the node enters the scene tree for the first time.
func _ready():
	var icon_texture: Texture2D = load(icon_filepath)
	button.icon = icon_texture
	button.tooltip_text = option_name
	button.toggled.connect(_on_button_toggled)

func _on_button_toggled(toggled: bool):
	if toggled:
		# call to get position of winnable against
		for lineEnd in endPosForLine:
			var line = winLineScene.instantiate()
			line.add_point(Vector2(0, 0))
			line.add_point(Vector2(lineEnd.x / 2, lineEnd.y / 2))
			line.add_point(lineEnd)
			lineHolder.add_child(line)
	else:
		for n: Node in lineHolder.get_children():
			lineHolder.remove_child(n)
			n.queue_free()