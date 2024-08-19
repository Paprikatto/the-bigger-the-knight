extends Control


func _ready() -> void:
	GameManager.game_over.connect(on_game_over)


func on_game_over():
	$AnimationPlayer.play("show")
	$AudioStreamPlayer2D.play()


func _on_replay_button_button_up() -> void:
	var p = get_parent()
	if p is LevelManager:
		p.restart_level()
	$AnimationPlayer.play_backwards("show")
