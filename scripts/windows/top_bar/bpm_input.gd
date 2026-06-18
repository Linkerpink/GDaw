extends HBoxContainer

@onready var bpm_menu_button : MenuButton = $BPMMenuButton
@export var tap_bpm_window_packed : PackedScene
@onready var spin_box: SpinBox = %BPMSpinBox


func _ready() -> void:
	bpm_menu_button.get_popup().id_pressed.connect(_on_item_pressed)
	_set_bpm(Project.bpm)


func _on_item_pressed(_id):
	var _item_name = bpm_menu_button.get_popup().get_item_text(_id)
	
	if _item_name == "Tap":
		WindowManager.create_window(tap_bpm_window_packed)


func _set_bpm(value: float) -> void:
	Project.set_bpm(value)
	spin_box.value = value
