class_name LevelSelectStar extends Star2D

@export var level_name = ""
@export var level_path = ""
@export var palette: Texture2D

@onready var scale_dynamics: DynamicsSolver = Dynamics.create_dynamics(5.0, 0.2, 2.0)
@onready var background_star: Star2D = $BackgroundStar

var is_selected = false

func _process(dt: float) -> void:
	rotation_degrees += dt * (120 if is_selected else 20)
	background_star.rotation_degrees = -rotation_degrees * 2.0
	scale = scale_dynamics.update(1.5 if is_selected else 1.0) * Vector2.ONE
	background_star.scale = background_star.scale.lerp(Vector2.ONE if is_selected else Vector2.ZERO, dt * 10)
	self_modulate = Color("#fff") if is_selected else Color("#ddd")
