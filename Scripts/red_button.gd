extends StaticBody2D
class_name RedButton

signal pressed
func pressed_signal_emit():
	pressed.emit()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.current_scale == 3:
			$AnimationPlayer.play("press")
			$Area2D.set_deferred("monitoring", false)
