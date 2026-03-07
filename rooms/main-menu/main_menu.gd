class_name MainMenu extends Room

@onready var star: Star2D = $Star2D
@onready var title_star: Star2D = $Title/Star
@onready var trailing_star: Star2D = $Star2D/TrailingStar
@onready var option_selector: NinePatchRect = $OptionSelector
@onready var selector_ping_timer: Timer = $SelectorPingTimer

@onready var star_rot_dynamics: DynamicsSolver = Dynamics.create_dynamics(4.0, 0.4, 2.0)

var target_rot = 0.0
var select_index = 0
var selector_target_y = 0.0
var original_selector_width = 0.0

func _ready() -> void:
	selector_target_y = option_selector.position.y
	original_selector_width = option_selector.size.x

func change_index(delta: int):
	select_index = wrapi(select_index + delta, 0, 3)
	target_rot += 45.0 * delta
	selector_ping_timer.start()

func _process(dt: float) -> void:
	star.rotation_degrees = star_rot_dynamics.update(target_rot)
	trailing_star.rotation_degrees = lerp(trailing_star.rotation_degrees, star.rotation_degrees + 12.0, 10.0 * dt)
	title_star.rotation_degrees += 160.0 * dt
	option_selector.position.y = lerp(option_selector.position.y, selector_target_y + select_index * 25.0, 25.0 * dt)
	option_selector.scale.x = lerp(option_selector.scale.x, 1.0, 10.0 * dt)

	if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("down"):
		change_index(1)
	elif Input.is_action_just_pressed("right") or Input.is_action_just_pressed("up"):
		change_index(-1)

func _on_selector_ping_timer_timeout() -> void:
	option_selector.scale.x = 1.05
