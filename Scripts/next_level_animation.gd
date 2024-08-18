extends Control


func play_anim(backwards: bool):
	if backwards:
		$AnimationPlayer.queue("back")
	else:
		$AnimationPlayer.play("fade")
