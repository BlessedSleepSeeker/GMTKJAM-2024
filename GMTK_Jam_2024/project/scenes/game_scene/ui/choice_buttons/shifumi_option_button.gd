
@tool
extends PathFollow2D
class_name ShifumiOptionButton

@export var option_name: String = "Rock"
@export var icons_path_template: String = "res://assets/openmoji/%s.png"
@onready var icon_filepath: String = icons_path_template % option_name
@onready var button = $Button
@onready var lineHolder = $LineHolder
@onready var winLineScene = preload("res://scenes/game_scene/ui/choice_buttons/win_against_line.tscn")
@onready var particles: GPUParticles2D = $Particles

signal play_button_toggled(toggled: bool, option_button: ShifumiOptionButton)

# Called when the node enters the scene tree for the first time.
func _ready():
	var icon_texture: Texture2D = load(icon_filepath)
	button.icon = icon_texture
	button.tooltip_text = option_name
	button.toggled.connect(_on_button_toggled)
	particles.texture = icon_texture

func _on_button_toggled(toggled: bool):
	play_button_toggled.emit(toggled, self)
	particles.emitting = toggled

func line_toggle(toggled: bool, endPosLine: Array[Vector2]):
	if toggled:
		for n: Node in lineHolder.get_children():
			lineHolder.remove_child(n)
			n.queue_free()
		#print_debug(option_name, endPosLine)
		# call to get position of winnable against
		for lineEnd in endPosLine:
			var line = winLineScene.instantiate()
			line.add_point(Vector2(0, 0))
			line.add_point(Vector2((lineEnd - self.global_position) / 2))
			line.add_point(lineEnd - self.global_position)
			lineHolder.add_child(line)
	else:
		for n: Node in lineHolder.get_children():
			lineHolder.remove_child(n)
			n.queue_free()
