extends Area2D
class_name Bullet

var speed: float = 0

func _process(delta: float) -> void:
	global_position.x += speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GameManager.game_over.emit()
	else:
		queue_free()
