extends Node3D

@onready var hand_controller: Node3D = $JoannaScene
@onready var camera: Camera3D = $Camera
@onready var camera_anim: AnimationPlayer = $AnimationPlayer

signal intro_finished
signal fight_finished

func play_hand_anim(anim_name: String) -> void:
	hand_controller.play_hand_anim(anim_name)

func play_hand_anim_backwards(anim_name: String) -> void:
	hand_controller.play_hand_anim_backwards(anim_name)

func pause_hand_anim() -> void:
	hand_controller.pause_hand_anim()

func play_intro():
	camera.make_current()
	print_debug("play cuscene")
	camera_anim.play("cutscene_intro")
	await camera_anim.animation_finished
	intro_finished.emit()

func play_fight(p1_play: String, p2_play: String) -> void:
	await get_tree().create_timer(0.5).timeout
	dramatic_finish()


func dramatic_finish():
	print_debug("play dramatic finish")
	camera_anim.play("dramatic_finish")
	await camera_anim.animation_finished
	fight_finished.emit()