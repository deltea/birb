extends AudioStreamPlayer

@export_category("Music")
@export var music_stream: AudioStream

@export_category("SFX")
@export var jump: AudioStream
@export var dash: AudioStream
@export var land: AudioStream
@export var bouncepad: AudioStream

var volume = 70

func _ready() -> void:
	connect("finished", func(): stream_paused = false)
	play_music(music_stream)

func play_music(music: AudioStream):
	stream = music
	play()

func play_sound(sound: AudioStream, randomness: float = 0):
	var player = AudioStreamPlayer.new()
	player.pitch_scale = randf_range(1 - randomness, 1 + randomness)
	player.stream = sound
	player.bus = "SFX"
	player.connect("finished", player.queue_free)
	add_child(player)
	player.play()

func set_sfx_volume(value: float):
	volume = clamp(value, 0, 1)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(volume))

func set_music_volume(value: float):
	volume = clamp(value, 0, 1)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(volume))
