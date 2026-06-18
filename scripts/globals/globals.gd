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


func _create_exclusive_window(_window, _window_packed):
	if _window:
		WindowManager.select_window(_window)
		_window.show()
	else:
		WindowManager.create_window(_window_packed)


func open_mixer():
	var mixer_window : GDawWindow = get_tree().get_first_node_in_group("mixer")
	var mixer_window_packed : PackedScene = load("res://scenes/components/windows/mixer/mixer.tscn")
	_create_exclusive_window(mixer_window, mixer_window_packed)


func open_settings():
	var settings_window : GDawWindow = get_tree().get_first_node_in_group("settings")
	var settings_window_packed : PackedScene = load("res://scenes/components/windows/settings_window.tscn")
	_create_exclusive_window(settings_window, settings_window_packed)
