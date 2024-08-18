extends Path2D

const SIZE = 250
const NUM_POINTS = 1000000

@export var speed: float = 0.1
@export var base_speed: float = 0.1
@export var max_speed: float = 3
@onready var uiViewport = get_parent().get_parent().get_parent().get_parent()

func _ready() -> void:
	curve = Curve2D.new()
	for i in NUM_POINTS:
		curve.add_point(Vector2(0, -SIZE).rotated((i / float(NUM_POINTS)) * TAU))

	# End the circle.
	curve.add_point(Vector2(0, -SIZE))

func _physics_process(_delta):
	if not Engine.is_editor_hint():
		for child: PathFollow2D in self.get_children():
			child.progress += speed
