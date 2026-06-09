extends Window
class_name TapBpmWindow

@onready var tap_button : Button = $MarginContainer/TapButton


func pop_up():
	visible = true
	tap_button.grab_focus()


func _on_close_requested() -> void:
	visible = false
