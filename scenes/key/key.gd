class_name Key extends Area2D

@onready var particles: CPUParticles2D = $Particles

var is_collected = false
var target_rotation = 0.0
var unlocking = false

func _process(dt: float) -> void:
	rotation_degrees = lerp(rotation_degrees, target_rotation, 10 * dt)
	target_rotation += (360 if is_collected else 90) * dt
	if is_collected and not unlocking:
		var player_pos = RoomManager.current_room.player.global_position
		global_position = global_position.lerp(player_pos + -(player_pos - global_position).normalized() * 24, 10 * dt)

func _on_body_entered(body: Node2D) -> void:
	if body is Player and not is_collected:
		particles.emitting = false
		is_collected = true
		target_rotation += 360

func unlock(door: Door):
	unlocking = true
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(self, "global_position", door.global_position, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	# tween.tween_property(self, "scale", Vector2.ZERO, 0.5)
	tween.chain().tween_callback(Callable(self, "queue_free"))
