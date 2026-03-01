class_name Room extends Node2D

@export var palette: Texture2D
@onready var time_label: RichTextLabel = $CanvasLayer/TimeLabel

var player: Player
var camera: Camera

var is_completed = false

func _enter_tree() -> void:
	RoomManager.current_room = self

func complete():
	PaletteFilter.set_brightness(0.25)
	is_completed = true

func _process(dt: float) -> void:
	if not is_completed:
		time_label.text = "[wave]%.2f[/wave]" % Clock.time
