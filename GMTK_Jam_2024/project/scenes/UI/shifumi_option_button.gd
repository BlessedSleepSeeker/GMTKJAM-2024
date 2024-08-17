
@tool
extends PathFollow2D

@export var option_name: String = "Rock"
@export var icons_path_template: String = "res://assets/openmoji/%s.png"
@onready var icon_filepath: String = icons_path_template % option_name
@onready var button = $Button

# Called when the node enters the scene tree for the first time.
func _ready():
	var icon_texture: Texture2D = load(icon_filepath)
	button.icon = icon_texture
	button.tooltip_text = option_name
