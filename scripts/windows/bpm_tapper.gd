extends Control

@onready var bpm_label : Label = %BPMLabel
@onready var tap_button : Button = $VBoxContainer/TapButton

var time_to_stop: float = 2.0
var tap_times: Array[float] = []
var bpm : float = 0.0
var bpm_before_tapping : float = 0.0


func _ready() -> void:
	bpm_before_tapping = Project.bpm
	bpm_label.text = "Tap to calculate BPM"
	
	tap_button.grab_focus()


func _tap_bpm() -> void:
	var current_time = Time.get_unix_time_from_system()
	
	if tap_times.size() > 0 and current_time - tap_times[-1] > time_to_stop:
		tap_times.clear()
	
	tap_times.append(current_time)
	_calculate_bpm()


func _on_reset_button_pressed() -> void:
	bpm = bpm_before_tapping
	Project.set_bpm(bpm_before_tapping)
	bpm_label.text = "Tap to calculate BPM"
	
	tap_times.clear()


func _calculate_bpm() -> void:
	if tap_times.size() < 2:
		bpm_label.text = "Calculating BPM"
	
	var time_diffs: Array[float] = []
	for i in range(1, tap_times.size()):
		time_diffs.append(tap_times[i] - tap_times[i-1])
	
	var average_diff: float = 0.0
	for diff in time_diffs:
		average_diff += diff
	average_diff /= time_diffs.size()
	
	if average_diff > 0:
		bpm = 60.0 / average_diff
		bpm_label.text = str(roundf(bpm))
		Project.set_bpm(bpm)
