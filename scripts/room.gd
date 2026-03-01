class_name Room extends Node2D

@export var palette: Texture2D

var player: Player
var camera: Camera

func _enter_tree() -> void:
	RoomManager.current_room = self

func complete():
	PaletteFilter.set_brightness(0.25)
