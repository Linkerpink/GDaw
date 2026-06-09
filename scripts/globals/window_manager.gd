extends Node

var window_selected : GDawWindow
var windows_open : Array[GDawWindow]


func open_window(_window : GDawWindow):
	windows_open.append(_window)
	select_window(_window)


func close_window(_window : GDawWindow):
	windows_open.erase(_window)
	if windows_open.size() > 0:
		select_window(windows_open.front())


func select_window(_window : GDawWindow):
	window_selected = _window
	print(window_selected)
