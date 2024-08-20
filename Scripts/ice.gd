extends StaticBody2D
class_name ice

var texture1 : Texture2D = preload("res://Sprites/ice.png")
var texture2 : Texture2D = preload("res://Sprites/ice2.png")

func _ready():
	GameManager.player_changed_size.connect(check_player)


func check_player():
	for x in $Area2D.get_overlapping_bodies():
		if x is Player:
			if x.current_scale != 1:
				self.queue_free()
				
func check_ice():
	for x in $Area2D.get_overlapping_bodies():
		print(x.name)
		if x is ice:
			if x.position.y > position.y :
				$Ice.texture = texture1

func _on_area_2d_body_entered(body):
	if body is Player:
		if body.current_scale != 1:
			self.queue_free()
 
