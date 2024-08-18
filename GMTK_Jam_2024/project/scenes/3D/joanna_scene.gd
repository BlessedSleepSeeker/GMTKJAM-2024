extends Node3D

@onready var hand_controller: Node3D = $Hand_Idle_outline
@onready var hand_controller2: Node3D = $Hand_Idle_outline2
@onready var p1_hands: Node3D = $P1HandHolder
@onready var p2_hands: Node3D = $P2HandHolder

@onready var sound_player1: AudioStreamPlayer = $PlayerSoundPlayer
@onready var sound_player2: AudioStreamPlayer = $PlayerSoundPlayer2
@onready var animator: AnimationPlayer = $Animator

signal shifumi_finished

func play_hand_anim(anim_name: String) -> void:
	hand_controller.play_hand_anim(anim_name)

func play_hand_anim_backwards(anim_name: String) -> void:
	hand_controller.play_hand_anim_backwards(anim_name)

func pause_hand_anim() -> void:
	hand_controller.pause_hand_anim()

func hide_hands() -> void:
	p1_hands.hide_all()
	p2_hands.hide_all()


func show_hands(p1_play: String, p2_play: String) -> void:
	p1_hands.show_hand(p1_play)
	p2_hands.show_hand(p2_play)

func show_idle() -> void:
	hand_controller.show()
	hand_controller2.show()

func hide_idle() -> void:
	hand_controller.hide()
	hand_controller2.hide()

func shifumi_anim(option_list: Array[String]):
	hide_idle()
	show_hands("Rock", "Rock")
	var speed: float = 1
	print_debug(option_list)
	for option in option_list:
		animator.play("shifumi", -1, speed, false)
		speed += 0.1
		await animator.animation_finished
	hide_hands()
	shifumi_finished.emit()