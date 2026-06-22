extends Range

@export var default_value : float = 0.0
var touching_mouse : bool = false


func _process(_delta: float) -> void:
	if touching_mouse:
		if Input.is_action_just_pressed("reset_value"):
			reset_to_default_value()


func change_to_value(_value : float):
	if not Settings.reduced_motion:
		var _tween = get_tree().create_tween()
		_tween.tween_property(self, "value", _value, Settings.default_animation_length / Settings.animation_speed)
	else:
		value = default_value


func reset_to_default_value():
	change_to_value(default_value)


func _on_mouse_entered() -> void:
	touching_mouse = true


func _on_mouse_exited() -> void:
	touching_mouse = false
