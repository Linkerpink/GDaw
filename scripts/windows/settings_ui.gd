extends TabContainer

#region Variables
#region Components
@onready var save_menu : Control = %SaveMenu

# General
@onready var project_path_label: RichTextLabel = %ProjectPathLabel
@onready var project_path_button: Button = %ProjectPathButton
@onready var select_project_path_window : Window = %SelectProjectPathWindow

# Audio
@onready var input_device_option_button: OptionButton = %InputDeviceOptionButton
@onready var output_device_option_button: OptionButton = %OutputDeviceOptionButton

# Video
@onready var animation_speed_slider: HSlider = %AnimationSpeedSlider
@onready var animation_speed_value_label: RichTextLabel = %AnimationSpeedValueLabel
@onready var reduced_motion_check_box: CheckBox = %ReducedMotionCheckBox
#endregion

#region Temp settings
# General
var projects_path = Settings.projects_path

# Audio
var input_device : String = Settings.input_device
var output_device : String = Settings.output_device

# Video
var animation_speed = Settings.animation_speed
var reduced_motion : bool = Settings.reduced_motion

# Shortcuts
#endregion
#endregion

#region UI management
func _ready() -> void:
	save_menu.hide()
	_refresh_ui()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("close_window"):
		_handle_window_closing()
	
	animation_speed_value_label.text = str(animation_speed_slider.value)


func _save_settings():
	Settings.projects_path = projects_path
	
	Settings.input_device = input_device
	Settings.output_device = output_device
	
	Settings.animation_speed = animation_speed
	Settings.reduced_motion = reduced_motion


func _load_settings():
	projects_path = Settings.projects_path
	
	input_device = Settings.input_device
	output_device = Settings.output_device
	
	animation_speed = Settings.animation_speed
	reduced_motion = Settings.reduced_motion


func _on_apply_button_pressed() -> void:
	_save_settings()
	Settings.save_settings()
	Settings.load_settings()
	save_menu.hide()
	_refresh_ui()


func _on_cancel_button_pressed() -> void:
	Settings.load_settings()
	_load_settings()
	save_menu.hide()
	_refresh_ui()


func _refresh_ui():
	_refresh_general_page()
	_refresh_audio_page()
	_refresh_video_page()


func _on_tab_clicked(tab: int) -> void:
	match tab:
		0:
			_refresh_general_page()
		1:
			_refresh_audio_page()


func _handle_window_closing():
	if select_project_path_window.visible:
		select_project_path_window.visible = false
	
	WindowManager.select_window(get_tree().get_first_node_in_group("settings"))


func _on_refresh_timer_timeout() -> void:
	if projects_path == Settings.projects_path and input_device == Settings.input_device and output_device == Settings.input_device and animation_speed == Settings.animation_speed and reduced_motion == Settings.reduced_motion:
		save_menu.hide()
	else:
		save_menu.show()
#endregion


#region General page
func _refresh_general_page():
	project_path_label.text = "Project Save Path: [color=yellow]" + str(Settings.projects_path)


func _on_project_path_button_pressed() -> void:
	select_project_path_window.current_dir = projects_path
	select_project_path_window.show()
	WindowManager.select_window(null)


func _on_select_project_path_window_dir_selected(dir: String) -> void:
	projects_path = dir
	project_path_label.text = "Project Save Path: [color=yellow]" + str(projects_path)
#endregion

#region Audio page
func _refresh_audio_page():
	_refresh_input_devices()
	_refresh_output_devices()


func _refresh_input_devices():
	input_device_option_button.clear()
	for i in AudioServer.get_input_device_list():
		input_device_option_button.add_item(i)
		if i == Settings.input_device:
			input_device_option_button.select(AudioServer.get_input_device_list().find(i))


func _refresh_output_devices():
	output_device_option_button.clear()
	for i in AudioServer.get_output_device_list():
		output_device_option_button.add_item(i)
		if i == Settings.output_device:
			output_device_option_button.select(AudioServer.get_output_device_list().find(i))


func _on_input_device_option_button_item_selected(index: int) -> void:
	input_device = AudioServer.get_input_device_list()[index]


func _on_output_device_option_button_item_selected(index: int) -> void:
	output_device = AudioServer.get_output_device_list()[index]
#endregion

#region Video page
func _refresh_video_page():
	animation_speed_slider.value = Settings.animation_speed
	animation_speed_value_label.text = str(animation_speed)
	
	reduced_motion_check_box.button_pressed = Settings.reduced_motion


func _on_animation_speed_slider_value_changed(value: float) -> void:
	animation_speed = animation_speed_slider.value


func _on_animations_enabled_check_box_toggled(toggled_on: bool) -> void:
	reduced_motion = toggled_on
#endregion
