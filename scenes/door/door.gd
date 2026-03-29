class_name Door extends StaticBody2D

@onready var sprite_top = $SpriteTop
@onready var sprite_bottom = $SpriteBottom
@onready var collider: CollisionShape2D = $CollisionShape
@onready var rumble_particles: CPUParticles2D = $RumbleParticles

func _process(dt: float) -> void:
	sprite_top.region_rect.position.y += 16 * dt
	sprite_bottom.region_rect.position.y += 16 * dt

func _on_unlock_area_area_entered(area: Area2D) -> void:
	if area is Key:
		(area as Key).unlock(self)
		await Clock.wait(0.5)
		collider.disabled = true
		rumble_particles.emitting = true
		var tween = get_tree().create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(sprite_top, "position:y", -32, 1).as_relative()
		tween.tween_property(sprite_bottom, "position:y", 32, 1).as_relative()
		tween.tween_callback(func(): RoomManager.current_room.camera.shake(1.2, 2.5))
		tween.tween_callback(func(): rumble_particles.emitting = false).set_delay(0.8)
