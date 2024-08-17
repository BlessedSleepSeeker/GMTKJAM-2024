extends Path2D

const SIZE = 250
const NUM_POINTS = 1000000

@export var speed: float = 0.001

func _ready() -> void:
	curve = Curve2D.new()
	for i in NUM_POINTS:
		curve.add_point(Vector2(0, -SIZE).rotated((i / float(NUM_POINTS)) * TAU))

	# End the circle.
	curve.add_point(Vector2(0, -SIZE))
	var length = curve.get_baked_length()
	var total_childs = self.get_child_count()
	var unit = length / total_childs
	var i = 0
	for child: PathFollow2D in self.get_children():
		child.progress = unit * i
		i += 1

func _physics_process(delta):
	if not Engine.is_editor_hint():
		for child: PathFollow2D in self.get_children():
			child.progress_ratio += 0.0002