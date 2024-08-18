extends StaticBody2D
class_name RedButton

signal pressed

func _ready() -> void:
	GameManager.player_changed_size.connect(check_for_player)

func pressed_signal_emit():
	pressed.emit()


func check_for_player():
	if not $Area2D.monitoring:
		return
	for b in $Area2D.get_overlapping_bodies():
		if b is Player:
			if b.current_scale == 3:
				press()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.current_scale == 3:
			press()

func press():
	$AnimationPlayer.play("press")
	$Area2D.set_deferred("monitoring", false)
