extends StaticBody2D

func _ready():
	GameManager.player_changed_size.connect(check_player)

func check_player():
	for x in $Area2D.get_overlapping_bodies():
		if x is Player:
			if x.current_scale != 1:
				self.queue_free()

func _on_area_2d_body_entered(body):
	if body is Player:
		if body.current_scale != 1:
			self.queue_free()
 
