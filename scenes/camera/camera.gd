class_name Camera extends Camera2D

@export var follow: Node2D
@export var rotation_speed = 5.0
@export var impact_rotation = 5.0
@export var shake_damping_speed = 2.0

@onready var pos_dynamics: DynamicsSolverVector = Dynamics.create_dynamics_vector(2.0, 0.8, 2.0)

var shake_duration = 0;
var shake_magnitude = 0;
var original_pos = Vector2.ZERO;
var target_zoom = Vector2.ONE

func _enter_tree() -> void:
	RoomManager.current_room.camera = self

func _ready() -> void:
	original_pos = offset

	# limit_top = -RoomManager.current_room.limit_y
	# limit_bottom = RoomManager.current_room.limit_y
	# limit_left = -RoomManager.current_room.limit_x
	# limit_right = RoomManager.current_room.limit_x

	reset_smoothing()

func _process(delta: float) -> void:
	if follow:
		var target_pos = follow.global_position
		global_position = pos_dynamics.update(target_pos)

	if shake_duration > 0:
		offset = original_pos + Vector2.from_angle(randf_range(0, PI*2)) * shake_magnitude
		shake_duration -= delta * shake_damping_speed
	else:
		shake_duration = 0
		offset = original_pos

func shake(duration: float, magnitude: float):
	shake_duration = duration
	shake_magnitude = magnitude

func impact():
	rotation_degrees = (1 if randf() > 0.5 else -1) * impact_rotation
