extends Control
class_name Mixer

@export_category("Component Variables")
@export var mixer_track_scene : PackedScene
@export var effect_track_scene : PackedScene

@onready var mixer_track_container : HBoxContainer = %MixerTrackContainer
@onready var effect_track_container : VBoxContainer = %EffectTrackContainer


func _ready() -> void:
	_set_new_mixer()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_mixer"):
		if visible:
			hide()
		else:
			show()


func _set_new_mixer():
	_clear_mixer()
	
	for i in 10:
		# Set mixer track
		var _mixer_track : MixerTrack = mixer_track_scene.instantiate()
		_mixer_track.track_numer = i + 1
		mixer_track_container.add_child(_mixer_track)
		
		# Set effect track
		var _effect_track = effect_track_scene.instantiate()
		_effect_track.track_numer = i + 1
		effect_track_container.add_child(_effect_track)


func _clear_mixer():
	# Clear mixer track container
	for i : Control in mixer_track_container.get_children():
		i.queue_free()
	
	# Clear effect track container
	for i : Control in effect_track_container.get_children():
		i.queue_free()
