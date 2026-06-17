extends Control

@onready var bpm_label : Label = $MarginContainer/VBoxContainer/BPMLabel
var bpm_before_tapping : float


func _ready() -> void:
	bpm_before_tapping = 120
	bpm_label.text = str(bpm_before_tapping)


func _tap_bpm() -> void:
	bpm_label.show()
	print("tap bpm")


func _on_reset_button_pressed() -> void:
	print("reset bpm")
