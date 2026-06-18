extends MenuButton

@onready var open_file_window : FileDialog = $OpenFileWindow
@onready var save_file_window : FileDialog = $SaveFileWindow


func _ready() -> void:
	get_popup().id_pressed.connect(_on_item_pressed)
	
	open_file_window.visible = false
	save_file_window.visible = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("close_window"):
		if open_file_window.visible:
			open_file_window.visible = false
		if save_file_window.visible:
			save_file_window.visible = false
	
	if Input.is_action_just_pressed("open_file") and not save_file_window.visible:
		open_open_file_window()
	
	if Input.is_action_just_pressed("save_file") and not open_file_window.visible:
		open_save_window()
	
	if Input.is_action_just_pressed("save_file_as") and not open_file_window.visible:
		open_save_window()


func _on_item_pressed(_id):
	var _item_name = get_popup().get_item_text(_id)
	
	match _item_name:
		"New":
			print("new")
		"Open":
			open_open_file_window()
		"Save":
			open_save_window()
		"Save As":
			open_save_window()


func open_open_file_window():
	open_file_window.current_dir = Settings.projects_path
	open_file_window.size = DisplayServer.window_get_size() / 1.5
	open_file_window.visible = true


func open_save_window():
	save_file_window.current_dir = Settings.projects_path
	save_file_window.size = DisplayServer.window_get_size() / 1.5
	save_file_window.visible = true


func _save_file(path: String) -> void:
	Project.file_name = path.get_file()
	var _file_dict = {
		"file_name" : Project.file_name,
		"bpm" : Project.bpm,
	}

	var _file = FileAccess.open(path, FileAccess.WRITE)
	var json_string = JSON.stringify(_file_dict, "\t")
	_file.store_string(json_string)
	_file.close()


func _load_file(path: String) -> void:
	if not FileAccess.file_exists(path):
		return
		
	var save_file = FileAccess.open(path, FileAccess.READ)
	var json_string = save_file.get_as_text()
	save_file.close()
	
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if parse_result != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return
		
	var _data = json.data
	#Project.file_name = _data["file_name"]
	Project.bpm = _data["bpm"]
	
	%BPMSpinBox.value = Project.bpm
