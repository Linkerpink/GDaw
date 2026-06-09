extends Control
class_name GDawWindow

@export var title : String = "Window"

@onready var title_label : RichTextLabel = %TitleLabel
@onready var top_bar : Control = %TopBar
@onready var top_bar_panel : Panel = %TopBarPanel

var touching_window : bool = false
var touching_top_bar : bool = false
var dragging : bool = false
var drag_point : Vector2


func _ready() -> void:
	title_label.text = title
	WindowManager.open_window(self)


func _process(_delta: float) -> void:
	_handle_selection()
	_handle_dragging()
	
	# Close input
	if Input.is_action_just_pressed("close_window") and WindowManager.window_selected == self:
		close_window()
	
	# Clamp window inside of the program
	global_position.x = clamp(global_position.x, 0, DisplayServer.window_get_size().x - size.x)
	global_position.y = clamp(global_position.y, 0, DisplayServer.window_get_size().y - size.y)


func _handle_selection():
	# Selection
	if get_local_mouse_position().x > 0 and get_local_mouse_position().x < size.x and get_local_mouse_position().y > 0 and get_local_mouse_position().y < size.y:
		touching_window = true
	else:
		touching_window = false
	
	if Input.is_action_just_pressed("left_click"):
		if touching_window and WindowManager.window_selected != self and not WindowManager.touching_window_selected:
			WindowManager.select_window(self)
		
		if not touching_window and not dragging:
			if WindowManager.window_selected == self:
				WindowManager.select_window(null)
	
	
	if WindowManager.window_selected == self:
		top_bar_panel.self_modulate = Color.WHITE
		owner.move_child(self, -1)
		z_index = 999
	else:
		top_bar_panel.self_modulate = Color.DIM_GRAY
		z_index = 900


func _handle_dragging():
	if Input.is_action_just_pressed("left_click"):
		# Drag mouse input
		if touching_top_bar:
			dragging = true
			drag_point = get_local_mouse_position()
		else:
			dragging = false
	
	if dragging and Input.is_action_just_released("left_click"):
		dragging = false
	
	# Drag keyboard input
	if Input.is_action_just_pressed("drag_window") and not Input.is_action_pressed("left_click") and WindowManager.window_selected == self:
		dragging = !dragging
		drag_point = get_local_mouse_position()
	
	# Drag logic
	if dragging:
		global_position = get_global_mouse_position() - drag_point


func close_window():
	pivot_offset = size / 2
	var _a_tween = get_tree().create_tween()
	_a_tween.tween_property(self, "modulate:a", 0, Settings.animation_length)
	
	var _s_tween = get_tree().create_tween()
	_s_tween.tween_property(self, "scale", Vector2(0.75, 0.75), Settings.animation_length)
	
	await get_tree().create_timer(Settings.animation_length).timeout
	WindowManager.close_window(self)
	queue_free()


func _on_top_bar_mouse_entered() -> void:
	touching_top_bar = true


func _on_top_bar_mouse_exited() -> void:
	touching_top_bar = false


func _on_close_button_pressed() -> void:
	close_window()
