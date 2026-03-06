extends Node

@export var slowmo_smoothing = 0.04

var time = 0.0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta: float) -> void:
	time += delta

func wait(duration: float):
	await get_tree().create_timer(duration, true, false, true).timeout

func hitstop(duration: float):
	Engine.time_scale = 0.0
	await wait(duration)
	Engine.time_scale = 1.0
