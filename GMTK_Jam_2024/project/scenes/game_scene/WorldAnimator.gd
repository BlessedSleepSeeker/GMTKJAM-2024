extends Node3D

@onready var hand_controller: Node3D = $JoannaScene
@onready var camera: Camera3D = $Camera
@onready var camera_anim: AnimationPlayer = $Camera/AnimationPlayer

signal intro_finished

func play_hand_anim(anim_name: String) -> void:
	hand_controller.play_hand_anim(anim_name)

func play_hand_anim_backwards(anim_name: String) -> void:
	hand_controller.play_hand_anim_backwards(anim_name)

func pause_hand_anim() -> void:
	hand_controller.pause_hand_anim()

func play_intro():
	camera_anim.play("cutscene_intro")
	await camera_anim.animation_finished
	intro_finished.emit()