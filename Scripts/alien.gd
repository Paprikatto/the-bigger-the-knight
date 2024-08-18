extends Node2D

@export var look_right: bool = false
@export var shoot_interval: float = 2
@export var first_shot_delay:float = 2
@export var shot_speed:float = 100
@export var bullet_scene: PackedScene


var shot_timer:float = 2
func _ready() -> void:
	shot_timer = first_shot_delay
	
	if look_right:
		$Sprite2D.flip_h = true
	else:
		#change the direction of a bullet
		shot_speed = -shot_speed


func _process(delta: float) -> void:
	if shot_timer > 0:
		shot_timer -= delta
	else:
		shoot()
		shot_timer = shoot_interval

func shoot():
	$AnimationPlayer.play("shoot")
	$AnimationPlayer.queue("idle")


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.current_scale == 3:
			$AnimationPlayer.play("death")
		else:
			GameManager.game_over.emit()
