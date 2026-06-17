extends Node


var min_screen_size : Vector2i = Vector2i(1024, 768)


func _ready() -> void:
	get_window().min_size = min_screen_size


func _process(delta: float) -> void:
	#region Shortcuts
	# Mixer
	if Input.is_action_just_pressed("toggle_mixer"):
		var mixer_window : GDawWindow = get_tree().get_first_node_in_group("mixer")
		var mixer_window_packed : PackedScene = load("res://scenes/components/windows/mixer/mixer.tscn")
		
		if mixer_window:
			WindowManager.select_window(mixer_window)
		else:
			WindowManager.create_window(mixer_window_packed)
	#endregion
