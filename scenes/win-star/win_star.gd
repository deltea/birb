class_name WinStar extends Node2D

@onready var back_star: Star2D = $BackStar
@onready var front_star: Star2D = $FrontStar
@onready var scale_dynamics: DynamicsSolverVector = Dynamics.create_dynamics_vector(8.0, 0.25, 2.0);

func _process(dt: float) -> void:
	scale = scale_dynamics.update(Vector2.ONE)
	back_star.rotation = Clock.time * 0.5
	front_star.rotation = -Clock.time
