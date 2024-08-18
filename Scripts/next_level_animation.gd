extends Control

func _ready() -> void:
	GameManager.next_level.connect(play_next_level)

func play_anim(backwards: bool):
	if backwards:
		$AnimationPlayer.queue("back")
	else:
		$AnimationPlayer.play("fade")

func play_next_level():
	$AnimationPlayer.play("fade")
	

func call_parent():
	var p = get_parent()
	if p is LevelManager:
		p.next_level()
