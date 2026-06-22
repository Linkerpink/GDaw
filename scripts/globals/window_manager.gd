extends Node

var window_selected : GDawWindow
var windows_open : Array[GDawWindow]
var touching_window_selected : bool


func _process(_delta: float) -> void:
	if window_selected:
		if window_selected.get_local_mouse_position().x > 0 and window_selected.get_local_mouse_position().x < window_selected.size.x and window_selected.get_local_mouse_position().y > 0 and window_selected.get_local_mouse_position().y < window_selected.size.y:
			touching_window_selected = true
		else:
			touching_window_selected = false


func create_window(_window_packed : PackedScene):
	var _window : GDawWindow = _window_packed.instantiate()
	get_tree().current_scene.add_child(_window)


func _create_exclusive_window(_window, _window_packed):
	if _window:
		select_window(_window)
		_window.show()
	else:
		create_window(_window_packed)


func open_window(_window : GDawWindow):
	windows_open.append(_window)
	select_window(_window)


func close_window(_window : GDawWindow):
	windows_open.erase(_window)
	if windows_open.size() > 0:
		select_window(windows_open.back())


func select_window(_window : GDawWindow):
	window_selected = _window
