extends Control
class_name MixerEffectTrack


@export var track_numer : int = -1
@export var track_name : String = "track"
@export var track_volume : float = 0.0
@export_range(-1,1) var effect_panning : float = 0.0

@onready var menu_button : MenuButton = %MenuButton
@onready var track_number_label : Label = %TrackNumberLabel

var track_effect : AudioEffect


func _ready() -> void:
	set_mixer_effect_track_name(str(track_numer) + ". Effect")


func set_mixer_effect_track_name(_name : String):
	track_name = _name
	menu_button.text = track_name
