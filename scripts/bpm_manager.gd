extends HBoxContainer

#@onready var bpm_menu_button : MenuButton = $BPMMenuButton
#@onready var tap_bpm_window : TapBpmWindow = $TapBPMWindow
#
#
#func _ready() -> void:
	#tap_bpm_window.visible = false
	#
	#bpm_menu_button.get_popup().id_pressed.connect(_on_item_pressed)
#
#
#func _on_item_pressed(_id):
	#var _item_name = bpm_menu_button.get_popup().get_item_text(_id)
	#
	#if _item_name == "Tap":
		#tap_bpm_window.pop_up()
