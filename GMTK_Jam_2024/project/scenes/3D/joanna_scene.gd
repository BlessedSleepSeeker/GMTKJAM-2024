extends Node3D

@onready var hand_controller: Node3D = $Hand_Idle_outline
@onready var p1_hands: Node3D = $P1HandHolder
@onready var p2_hands: Node3D = $P2HandHolder

func play_hand_anim(anim_name: String) -> void:
	hand_controller.play_hand_anim(anim_name)

func play_hand_anim_backwards(anim_name: String) -> void:
	hand_controller.play_hand_anim_backwards(anim_name)

func pause_hand_anim() -> void:
	hand_controller.pause_hand_anim()

func hide_hands():
	p1_hands.hide_all()
	p2_hands.hide_all()

func show_hands(p1_play: String, p2_play: String):
	p1_hands.show_hand(p1_play)
	p2_hands.show_hand(p2_play)