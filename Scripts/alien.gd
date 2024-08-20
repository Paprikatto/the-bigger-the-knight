extends Node2D

@export_category("Shooting")
@export var look_right: bool = false
@export var shoot_interval: float = 2
@export var first_shot_delay:float = 2
@export var shot_speed:float = 100
@export var bullet_scene: PackedScene

@export_category("Variants")
enum Biome {DEFAULT, WINTER, MAGMA}
@export var biome: Biome = Biome.DEFAULT
@export var winter_texture: Texture2D
@export var magma_texture: Texture2D

var shot_timer:float = 2
func _ready() -> void:
	if biome == Biome.WINTER:
		$Sprite2D.texture = winter_texture
	elif biome == Biome.MAGMA:
		$Sprite2D.texture = magma_texture
	
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
	#make sure that alien dont shoot during death animation
	if $AnimationPlayer.current_animation == "death":
		return
	if bullet_scene != null:
		var bullet = bullet_scene.instantiate()
		#make sure that assigned packed scene is of type Bullet
		if bullet is Bullet:
			get_parent().add_child(bullet)
			#chose bullet spawn point based on facing direction
			if look_right:
				bullet.set_global_position($BulletSpawnRight.global_position)
			else:
				bullet.set_global_position($BulletSpawnLeft.global_position)
			bullet.speed = shot_speed
		else:
			bullet.queue_free()
			return
	else:
		return
	$AnimationPlayer.play("shoot")
	$AnimationPlayer.queue("idle")
	$AudioStreamPlayer2D.play()



func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.current_scale == 3:
			$AnimationPlayer.play("death")
		else:
			GameManager.game_over.emit()

func death():
	queue_free()
