@tool
extends Node

const SETTINGS_FILE_PATH = "user://settings.cfg"

@export_tool_button("Delete settings", "Remove") var delete_settings_button = Callable(self, "delete_settings")

func save_settings(sfx_volume, music_volume):
	var config = ConfigFile.new()

	config.set_value("Audio", "SFXVolume", sfx_volume)
	config.set_value("Audio", "MusicVolume", music_volume)
	# config.set_value("Graphics", "WindowSize", window_size)

	AudioManager.set_sfx_volume(sfx_volume / 4.0 * 100)
	AudioManager.set_music_volume(music_volume / 4.0)

	var err = config.save(SETTINGS_FILE_PATH)
	if err != OK:
			print("failed to save settings: ", error_string(err))

func load_settings():
	var config = ConfigFile.new()
	config.load(SETTINGS_FILE_PATH)

	var sfx_volume = config.get_value("Audio", "SFXVolume", 4.0)
	var music_volume = config.get_value("Audio", "MusicVolume", 4.0)

	AudioManager.set_sfx_volume(sfx_volume / 4.0)
	AudioManager.set_music_volume(music_volume / 4.0)

	return {
		"SFXVolume": sfx_volume,
		"MusicVolume": music_volume,
		# "WindowSize": window_size
	}

func delete_settings():
	if FileAccess.file_exists(SETTINGS_FILE_PATH):
		DirAccess.remove_absolute(SETTINGS_FILE_PATH)
		print("settings deleted")
	else:
		print("no settings file to delete")
