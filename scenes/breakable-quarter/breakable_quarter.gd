class_name BreakableQuarter extends Sprite2D

@export var gravity = 800.0

var enabled = false
var constant_rot = 0.0
var velocity = Vector2.ZERO

func _process(dt: float) -> void:
	if not enabled: return

	velocity.y += gravity * dt
	position += velocity * dt
	rotation_degrees += constant_rot * dt
