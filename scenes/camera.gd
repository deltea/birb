class_name Camera extends Camera2D

@export var follow: Node2D
@export var follow_speed = 5.0

@onready var pos_dynamics: DynamicsSolverVector = Dynamics.create_dynamics_vector(2.0, 0.8, 2.0)

func _process(delta: float) -> void:
	if follow:
		var target_pos = follow.global_position
		global_position = pos_dynamics.update(target_pos)
