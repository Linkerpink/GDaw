extends Node


var min_screen_size : Vector2i = Vector2i(1024, 768)


func _ready() -> void:
	get_window().min_size = min_screen_size


func _process(_delta: float) -> void:
	#region Shortcuts
	# Mixer
	if Input.is_action_just_pressed("open_mixer"):
		open_mixer()
	
	# Settings
	if Input.is_action_just_pressed("open_settings"):
		open_settings()
	#endregion


func open_mixer():
	var mixer_window : GDawWindow = get_tree().get_first_node_in_group("mixer")
	var mixer_window_packed : PackedScene = load("res://scenes/components/windows/mixer/mixer.tscn")
	WindowManager._create_exclusive_window(mixer_window, mixer_window_packed)


func open_settings():
	var settings_window : GDawWindow = get_tree().get_first_node_in_group("settings")
	var settings_window_packed : PackedScene = load("res://scenes/components/windows/settings_window.tscn")
	WindowManager._create_exclusive_window(settings_window, settings_window_packed)
