extends Node3D

@onready var particles: GPUParticles3D = $GPUParticles3D
@onready var hand: Skeleton3D = $Skeleton3D

func hide_hand():
	hand.hide()

func show_hand():
	hand.show()

func explode() -> void:
	particles.emitting = true