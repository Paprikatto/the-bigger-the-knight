extends StaticBody2D

var broken: bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if broken:
		return
	if body is Player:
		print(body.current_just_landed)
		if body.current_scale == 3 and body.current_just_landed > 0:
			$AnimatedSprite2D.play("break")
			$CollisionShape2D.set_deferred("disabled", true)
			broken = true
