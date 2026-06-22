extends Control
class_name GDawWindow

@export var title : String = "Window"

@onready var title_label : RichTextLabel = %TitleLabel
@onready var top_bar : Control = %TopBar
@onready var top_bar_panel : Panel = %TopBarPanel
@onready var window_content : Control = %WindowContent

var touching_window : bool = false
var touching_top_bar : bool = false
var dragging : bool = false
var drag_point : Vector2

var resize_bar_touching : String
var resize_bar_dragging : String
var resizing : bool = false

@onready var resize_bar_top : Control = $ResizeBars/ResizeBarTop
@onready var resize_bar_left : Control = $ResizeBars/ResizeBarLeft
@onready var resize_bar_right : Control = $ResizeBars/ResizeBarRight
@onready var resize_bar_bottom : Control = $ResizeBars/ResizeBarBottom
@onready var resize_bar_top_left : Control = $ResizeBars/ResizeBarTopLeft
@onready var resize_bar_bottom_left : Control = $ResizeBars/ResizeBarBottomLeft
@onready var resize_bar_top_right : Control = $ResizeBars/ResizeBarTopRight
@onready var resize_bar_bottom_right : Control = $ResizeBars/ResizeBarBottomRight


func _ready() -> void:
	title_label.text = title
	_open_window()


func _process(delta: float) -> void:
	_handle_selection()
	_handle_dragging()
	_handle_resizing(delta)
	
	# Close input
	if Input.is_action_just_pressed("close_window") and WindowManager.window_selected == self:
		close_window()
	
	# Clamp window inside of the program
	global_position.x = clamp(global_position.x, 0, DisplayServer.window_get_size().x - size.x)
	global_position.y = clamp(global_position.y, 0, DisplayServer.window_get_size().y - size.y)


func _handle_selection():
	# Selection
	if resize_bar_touching != "":
		touching_window = true
	elif get_local_mouse_position().x > 0 and get_local_mouse_position().x < size.x and get_local_mouse_position().y > 0 and get_local_mouse_position().y < size.y:
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


func _handle_resizing(_delta: float):
	if Input.is_action_just_pressed("left_click"):
		if resize_bar_touching != "":
			resizing = true
			resize_bar_dragging = resize_bar_touching
	
	if Input.is_action_just_released("left_click"):
		resize_bar_dragging = ""
		resizing = false
	
	#TODO fix resizing too far for one frame in the resizebarleft
	if resizing:
		match resize_bar_dragging:
			"ResizeBarTop":
				if get_local_mouse_position().y < 0 and get_global_mouse_position().y > 0:
					size.y -= get_local_mouse_position().y
					position.y = get_global_mouse_position().y
				elif get_local_mouse_position().y > 0 and size.y != get_custom_minimum_size().y:
					size.y -= get_local_mouse_position().y
					position.y = get_global_mouse_position().y - get_local_mouse_position().y / size.y / 2
			
			"ResizeBarLeft":
				if get_local_mouse_position().x < 0 and get_global_mouse_position().x > 0:
					size.x -= get_local_mouse_position().x
					position.x = get_global_mouse_position().x
				elif get_local_mouse_position().x > 0 and size.x != get_custom_minimum_size().x:
					size.x -= get_local_mouse_position().x
					position.x = get_global_mouse_position().x - get_local_mouse_position().x / size.x / 2
			
			"ResizeBarRight":
				if get_local_mouse_position().x < DisplayServer.window_get_size().x and get_global_mouse_position().x < DisplayServer.window_get_size().x:
					size.x = get_local_mouse_position().x
			
			"ResizeBarBottom":
				if get_global_mouse_position().y < DisplayServer.window_get_size().y:
					size.y = get_local_mouse_position().y
			
			"ResizeBarTopLeft":
				if get_local_mouse_position().x < 0 and get_global_mouse_position().x > 0:
					size.x -= get_local_mouse_position().x
					position.x = get_global_mouse_position().x
				elif get_local_mouse_position().x > 0 and size.x != get_custom_minimum_size().x:
					size.x -= get_local_mouse_position().x
					position.x = get_global_mouse_position().x - get_local_mouse_position().x / size.x / 2
				
				if get_local_mouse_position().y < 0 and get_global_mouse_position().y > 0:
					size.y -= get_local_mouse_position().y
					position.y = get_global_mouse_position().y
				elif get_local_mouse_position().y > 0 and size.y != get_custom_minimum_size().y:
					size.y -= get_local_mouse_position().y
					position.y = get_global_mouse_position().y - get_local_mouse_position().y / size.y / 2
			
			"ResizeBarBottomLeft":
				if get_local_mouse_position().x < 0 and get_global_mouse_position().x > 0:
					size.x -= get_local_mouse_position().x
					position.x = get_global_mouse_position().x
				elif get_local_mouse_position().x > 0 and size.x != get_custom_minimum_size().x:
					size.x -= get_local_mouse_position().x
					position.x = get_global_mouse_position().x - get_local_mouse_position().x / size.x / 2
				
				if get_global_mouse_position().y < DisplayServer.window_get_size().y:
					size.y = get_local_mouse_position().y
			
			"ResizeBarTopRight":
				if get_local_mouse_position().x < DisplayServer.window_get_size().x and get_global_mouse_position().x < DisplayServer.window_get_size().x:
					size.x = get_local_mouse_position().x
				
				if get_local_mouse_position().y < 0 and get_global_mouse_position().y > 0:
					size.y -= get_local_mouse_position().y
					position.y = get_global_mouse_position().y
				elif get_local_mouse_position().y > 0 and size.y != get_custom_minimum_size().y:
					size.y -= get_local_mouse_position().y
					position.y = get_global_mouse_position().y - get_local_mouse_position().y / size.y / 2
			
			"ResizeBarBottomRight":
				if get_local_mouse_position().x < DisplayServer.window_get_size().x and get_global_mouse_position().x < DisplayServer.window_get_size().x:
					size.x = get_local_mouse_position().x
				if get_global_mouse_position().y < DisplayServer.window_get_size().y:
					size.y = get_local_mouse_position().y


func _open_window():
	modulate.a = 0
	scale = Vector2(.75, .75)
	#pivot_offset = size / 2
	
	WindowManager.open_window(self)
	
	if not Settings.reduced_motion:
		var _a_tween = get_tree().create_tween()
		
		_a_tween.tween_property(self, "modulate:a", 1, Settings.default_animation_length / Settings.animation_speed)
		
		var _s_tween = get_tree().create_tween()
		_s_tween.tween_property(self, "scale", Vector2(1, 1), Settings.default_animation_length / Settings.animation_speed)
	else:
		modulate.a = 1
		scale = Vector2.ONE


func close_window():
	if not Settings.reduced_motion:
		#pivot_offset = size / 2
		var _a_tween = get_tree().create_tween()
		_a_tween.tween_property(self, "modulate:a", 0, Settings.default_animation_length / Settings.animation_speed)
		
		var _s_tween = get_tree().create_tween()
		_s_tween.tween_property(self, "scale", Vector2(0.75, 0.75), Settings.default_animation_length / Settings.animation_speed)
		
		await get_tree().create_timer(Settings.default_animation_length / Settings.animation_speed).timeout
	
	WindowManager.close_window(self)
	queue_free()


func _on_top_bar_mouse_entered() -> void:
	touching_top_bar = true


func _on_top_bar_mouse_exited() -> void:
	touching_top_bar = false


func _on_close_button_pressed() -> void:
	close_window()


func _on_resize_bar_mouse_entered(_name : String):
	if not resizing:
		resize_bar_touching = _name


func _on_resize_bar_mouse_exited() -> void:
	resize_bar_touching = ""
