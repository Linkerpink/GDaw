extends Node

var settings_dict : Dictionary

# General
var projects_path = OS.get_environment("USERPROFILE") + "/Documents"

# Audio
var input_device : String
var output_device : String

# Video
var default_animation_length = .125
var animation_speed = 1

# Shortcuts


func _ready() -> void:
	if FileAccess.file_exists("user://settings.sav"):
		load_settings()
	else:
		save_settings()


func save_settings():
	settings_dict = {
		"projects_path" : projects_path,
		"animation_speed" : animation_speed,
	}
	
	var settings_file = FileAccess.open("user://settings.sav", FileAccess.WRITE)
	var json_string = JSON.stringify(settings_dict, "\t")
	settings_file.store_string(json_string)
	settings_file.close()


func load_settings():
	if not FileAccess.file_exists("user://settings.sav"):
		return
		
	var save_file = FileAccess.open("user://settings.sav", FileAccess.READ)
	var json_string = save_file.get_as_text()
	save_file.close()
	
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if parse_result != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return
		
	settings_dict = json.data
	
	projects_path = settings_dict["projects_path"]
	animation_speed = settings_dict["animation_speed"]
