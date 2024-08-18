
@tool
extends PathFollow2D
class_name ShifumiOptionButton

@export var option_name: String = "Rock"
@export var disabled: bool = false
@export var icons_path_template: String = "res://assets/openmoji/%s.png"
@export var sound_path_template: String = "res://assets/sounds/options/voice%d/%s.mp3"

@onready var icon_filepath: String = icons_path_template % option_name

@onready var button = $Button
@onready var lineHolder = $LineHolder
@onready var particles: GPUParticles2D = $Particles
@onready var hexagon = $Hexagon
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var winLineScene = preload("res://scenes/game_scene/ui/choice_buttons/win_against_line.tscn")
@onready var sound_player: AudioStreamPlayer = $SoundPlayer


signal play_button_toggled(toggled: bool, option_button: ShifumiOptionButton)

# Called when the node enters the scene tree for the first time.
func _ready():
	var icon_texture: Texture2D = load(icon_filepath)
	button.icon = icon_texture
	button.tooltip_text = option_name
	button.toggled.connect(_on_button_toggled)
	particles.texture = icon_texture


func load_sound(_round: int):
	var voice = int(round(randi_range(1, 2)))
	print(voice)
	var sound: AudioStream = load(sound_path_template % [voice, option_name])
	sound_player.stream = sound
	
func _on_sound_player_finished() -> void:
	load_sound(0)

func _on_button_toggled(toggled: bool):
	play_button_toggled.emit(toggled, self)
	particles.emitting = toggled
	if toggled:
		sound_player.play()
		anim_player.play("pressed")
	else:
		anim_player.play_backwards("pressed")


func disabled_toggle(disable: bool, p1_or_p2: bool):
	if disable:
		if p1_or_p2:
			anim_player.play("disable_p1")
			button.tooltip_text += "\nCan't play this round !"
			particles.hide()
			button.disabled = true
		else:
			anim_player.play("disable_p2")
			button.tooltip_text += "\nCPU can't play it this round !"
	else:
		particles.show()
		button.disabled = false
		button.tooltip_text = ""


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
		await get_tree().create_timer(1000).timeout
		for n: Node in lineHolder.get_children():
			lineHolder.remove_child(n)
			n.queue_free()
