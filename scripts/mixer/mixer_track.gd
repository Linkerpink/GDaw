extends Control
class_name MixerTrack


enum TrackTypes{
	Master,
	Normal,
}
@export var track_type : TrackTypes = TrackTypes.Normal
@export var track_numer : int = -1
@export var track_name : String = "track"
@export var track_volume : float = 0.0
@export_range(-1,1) var track_panning : float = 0.0

@onready var line_edit : LineEdit = %LineEdit
@onready var track_number_label : Label = %TrackNumberLabel

var muted : bool = false
var solo : bool = false


func _ready() -> void:
	if track_type != TrackTypes.Master:
		set_mixer_track_name("Track " + str(track_numer))
	else:
		_set_master()
	
	track_number_label.text = str(track_numer) + "."


func set_mixer_track_name(_name : String):
	track_name = _name
	line_edit.text = track_name


func _set_master():
	set_mixer_track_name("Master")
	track_numer = 0
	line_edit.editable = false
	line_edit.selecting_enabled = false
	line_edit.focus_mode = Control.FOCUS_NONE
