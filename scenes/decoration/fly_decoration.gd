class_name FlyDecoration extends AnimatedSprite2D

@export var noise: NoiseTexture2D
@export var area_size = 35.0
@export var speed = 500.0

var original_pos = Vector2.ZERO

func _ready() -> void:
	original_pos = position
	noise.noise.seed = randi()
	play()

func _process(dt: float) -> void:
	# move position based on noise
	var noise_x = noise.noise.get_noise_2d(position.x + Clock.time * speed, position.y)
	var noise_y = noise.noise.get_noise_2d(position.x, position.y + Clock.time * speed)
	position = original_pos + Vector2(noise_x * area_size, noise_y * area_size)
