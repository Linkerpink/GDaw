extends MenuButton


func _ready() -> void:
	get_popup().id_pressed.connect(_on_item_pressed)


func _on_item_pressed(_id):
	var _item_name = get_popup().get_item_text(_id)
	
	match _item_name:
		"General":
			pass
		"Audio":
			pass
		"Video":
			pass
		"Shortcuts":
			pass
