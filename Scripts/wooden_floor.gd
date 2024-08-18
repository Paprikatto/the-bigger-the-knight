extends StaticBody2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.current_scale == 3:
			$AnimatedSprite2D.play("break")
			$CollisionShape2D.set_deferred("disabled", true)
