extends Node

var file_name : String = "project"
var bpm : float = 120

var bpm_manager : Control
var bpm_spin_box : SpinBox


func _ready() -> void:
	bpm_manager = get_tree().get_first_node_in_group("bpm_manager")
	bpm_spin_box = bpm_manager.find_child("BPMSpinBox")


func set_bpm(_bpm : float):
	bpm = _bpm
	bpm_spin_box.value = bpm
