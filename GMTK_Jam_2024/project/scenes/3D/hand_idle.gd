extends Node3D

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func play_hand_anim(anim_name: String) -> void:
	anim_player.play(anim_name)

func play_hand_anim_backwards(anim_name: String) -> void:
	anim_player.play_backwards(anim_name)

func pause_hand_anim() -> void:
	anim_player.pause()