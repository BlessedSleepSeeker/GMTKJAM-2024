extends Control

@export var creditsScenePath := "res://scenes/menu/credit_scene.tscn"
@export var gameSettingPath := "res://scenes/game_scene/game.tscn"
@export var settings_screen_path := "res://scenes/menu/settings/settings_screen.tscn"
@export var camera_speed: float = 0.00001


@onready var camera: Camera3D = $Node3D/Camera3D
@onready var sound_player: RandomStreamPlayer = $RandomStreamPlayer

signal transition(new_scene: PackedScene, animation: String)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_quit_button_pressed():
	get_tree().quit()

func _on_credits_button_pressed():
	var creditsScene = load(creditsScenePath)
	transition.emit(creditsScene, "scene_transition")

func _on_play_button_pressed():
	var gameScene = load(gameSettingPath)
	transition.emit(gameScene, "scene_transition")

func _on_settings_pressed():
	var settings_scene = load(settings_screen_path)
	transition.emit(settings_scene, "scene_transition")

func _process(delta):
	camera.rotate_y(camera_speed)


func _on_exit_mouse_entered():
	sound_player.play_random()


func _on_settings_mouse_entered():
	sound_player.play_random()


func _on_credits_mouse_entered():
	sound_player.play_random()


func _on_play_mouse_entered():
	sound_player.play_random()
