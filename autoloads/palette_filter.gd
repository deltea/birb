extends CanvasLayer

@export var default_palette: Texture2D
@export var brightness_change_speed = 15.0

@onready var color_rect: ColorRect = $ColorRect

var palette: Texture2D
var target_brightness = 1.0
var brightness = 1.0

func set_color_palette(new_palette: Texture2D = null):
	if not default_palette:
		print("default palette not set")
		return

	palette = default_palette
	if new_palette:
		palette = new_palette

	print("color palette changed to " + palette.resource_path)
	$ColorRect.material.set_shader_parameter("palette_out", palette)

func set_brightness(value: float):
	target_brightness = value

func _process(dt: float) -> void:
	brightness = lerp(brightness, target_brightness, dt * brightness_change_speed)
	$ColorRect.material.set_shader_parameter("brightness", brightness)
