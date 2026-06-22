extends MenuButton


func _ready() -> void:
	get_popup().id_pressed.connect(_on_item_pressed)


func _on_item_pressed(_id):
	var _item_name = get_popup().get_item_text(_id)
	
	var _settings_window : GDawWindow = get_tree().get_first_node_in_group("settings")
	var _settings_window_packed : PackedScene = load("res://scenes/components/windows/settings_window.tscn")
	WindowManager._create_exclusive_window(_settings_window, _settings_window_packed)
	
	var _settings_tab_container : TabContainer = get_tree().get_first_node_in_group("settings").window_content.get_child(0).get_child(0)
	
	match _item_name:
		"General":
			_settings_tab_container.current_tab = 0
		"Audio":
			_settings_tab_container.current_tab = 1
		"Video":
			_settings_tab_container.current_tab = 2
		"Shortcuts":
			_settings_tab_container.current_tab = 3
