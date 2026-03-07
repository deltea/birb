extends CanvasLayer

@onready var player: AnimationPlayer = $AnimationPlayer

var current_room: Room

func _ready() -> void:
	player.play("transition")
	PaletteFilter.set_color_palette(current_room.palette)

func change_room(room: String):
	player.play_backwards("transition")
	await Clock.wait(player.current_animation_length)

	var path = "res://rooms/" + room + ".tscn"
	if !ResourceLoader.exists(path):
		printerr("room not found: " + path)
		return

	var scene = load(path)

	await Clock.wait(player.current_animation_length)
	player.play("transition")
	get_tree().change_scene_to_packed(scene)

func change_room_from_scene(scene: PackedScene):
	player.play_backwards("transition")
	await Clock.wait(player.current_animation_length)

	get_tree().change_scene_to_packed(scene)

	await Clock.wait(player.current_animation_length)

	player.play("transition")

func restart_room():
	player.play_backwards("transition")
	await Clock.wait(player.current_animation_length)

	get_tree().paused = false
	# get_tree().reload_current_scene()
	change_room("level")

	await Clock.wait(player.current_animation_length)

	player.play("transition")
