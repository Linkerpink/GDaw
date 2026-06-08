extends Range

var touching_mouse : bool = false


func _process(delta: float) -> void:
	if touching_mouse:
		if Input.is_action_just_pressed("reset_value"):
			var _tween = get_tree().create_tween()
			_tween.tween_property(self, "value", 0, .125)


func _on_mouse_entered() -> void:
	touching_mouse = true


func _on_mouse_exited() -> void:
	touching_mouse = false
