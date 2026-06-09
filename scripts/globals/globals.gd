extends Node


var min_screen_size : Vector2i = Vector2i(1024, 768)


func _ready() -> void:
	get_window().min_size = min_screen_size
