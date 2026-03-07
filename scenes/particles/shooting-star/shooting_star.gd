class_name ShootingStar extends Node2D

@onready var particles: CPUParticles2D = $CPUParticles

var dir = Vector2.RIGHT

func _process(dt: float) -> void:
	position += dir * 100.0 * dt
	# oscillate the star's y position
	particles.position.y = sin(Clock.time * 5.0) * 4.0
