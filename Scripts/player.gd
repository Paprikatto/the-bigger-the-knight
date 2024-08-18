extends CharacterBody2D
class_name Player


@export var move_speed: float = 80

#components
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var scale_animations: AnimationPlayer = $ScaleAnimations
@onready var sprite: Sprite2D = $Sprite2D

#1 is small, 2 is normal, 3 is big
var current_scale: int = 2

#scale checks
@export var big_check: Area2D
@export var normal_check: Area2D

#used in scaling
@export var jump_factor: float = 1
@export var move_factor: float = 1

#jumping
var jump_force:float = 200
var gravity:float = 7
var max_fall_speed:float = 300
var fall_factor: float = 1.5

##how early before landing on the ground I can hit space so as soon as i land, player immediately jumps
@export var jump_buffer: float = 0.1
var current_jump_buffer: float = 0

#just landed check
var current_just_landed: float = 0
var just_landed_time: float = 0.2



var last_dist: float

func _ready() -> void:
	$ScaleAnimations.play("RESET")
	GameManager.game_over.connect(on_game_over)
	
	velocity.x = move_speed
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if is_on_floor():
			jump()
		else:
			current_jump_buffer = jump_buffer
	elif event.is_action_pressed("scale_up"):
		scale_up()
	elif event.is_action_pressed("scale_down"):
		scale_down()
		

func _physics_process(_delta: float) -> void:
	if not is_on_floor():
		if velocity.y != max_fall_speed:
			if velocity.y < 0:
				velocity.y += gravity
			else:
				velocity.y += gravity * fall_factor
	elif velocity.y > 5:
		velocity.y = 0
	
	velocity.x = Input.get_axis("move_left","move_right") * move_speed * move_factor
	
	if velocity.x:
		animations.play("walk")
		if velocity.x < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	else:
		animations.play("idle")
	
	move_and_slide()

func _process(delta: float) -> void:
	#timers
	if current_jump_buffer > 0:
		current_jump_buffer -= delta
	if current_just_landed > 0:
		current_just_landed -= delta
		
	#jump buffer
	if is_on_floor() and current_jump_buffer > 0:
		jump()
	
	

func jump():
	velocity.y = -jump_force * jump_factor

#region Scaling
func scale_up():
	if $ScaleAnimations.is_playing():
		return
	if current_scale == 1 and not normal_check.has_overlapping_bodies():
		scale_animations.play_backwards("normal_to_small")
	elif current_scale == 2 and not big_check.has_overlapping_bodies():
		scale_animations.play("normal_to_big")
	else:
		return
	current_scale += 1
	
func scale_down():
	if $ScaleAnimations.is_playing():
		return
	#animations
	if current_scale == 2:
		scale_animations.play("normal_to_small")
	elif current_scale == 3:
		scale_animations.play_backwards("normal_to_big")
	else: 
		return
	
	current_scale -= 1
#endregion
	


func _on_collision_area_body_entered(body: Node2D) -> void:
	if body is CollisionObject2D:
		if body.get_collision_layer_value(3):
			GameManager.game_over.emit()

func on_game_over():
	self.queue_free()


func _on_interactable_check_area_entered(area: Area2D) -> void:
	current_just_landed = just_landed_time
