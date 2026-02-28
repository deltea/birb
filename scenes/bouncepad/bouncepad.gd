class_name Bouncepad extends StaticBody2D

signal bounce

@onready var sprite: Sprite2D = $Sprite

@onready var scale_dynamics: DynamicsSolverVector = Dynamics.create_dynamics_vector(5.0, 0.2, 2.0)

func _process(dt: float) -> void:
	sprite.scale = scale_dynamics.update(Vector2.ONE)

func _on_bounce() -> void:
	scale_dynamics.set_value(Vector2.ONE + Vector2(0.4, -0.8))
