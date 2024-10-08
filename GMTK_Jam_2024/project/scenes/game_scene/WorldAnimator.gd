extends Node3D

@onready var hand_controller: Node3D = $JoannaScene
@onready var camera: Camera3D = $Camera
@onready var camera_anim: AnimationPlayer = $AnimationPlayer

signal intro_finished
signal fight_finished

func hide_hands() -> void:
	hand_controller.hide_hands()
	hand_controller.show_idle()

func play_intro():
	camera.make_current()
	print_debug("play cuscene")
	camera_anim.play("cutscene_intro")
	await camera_anim.animation_finished
	intro_finished.emit()


func play_fight(p1_play: String, p2_play: String, option_list: Array[String]) -> void:
	hand_controller.shifumi_anim(option_list)
	await hand_controller.shifumi_finished
	hand_controller.hide_idle()
	hand_controller.show_hands(p1_play, p2_play)
	dramatic_finish()


func dramatic_finish():
	print_debug("play dramatic finish")
	camera_anim.play("dramatic_finish")
	await camera_anim.animation_finished
	fight_finished.emit()
