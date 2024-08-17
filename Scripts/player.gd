extends CharacterBody2D



@export var move_speed: float = 50

@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var scale_animations: AnimationPlayer = $ScaleAnimations
@onready var sprite: Sprite2D = $Sprite2D

#1 is small, 2 is normal, 3 is big
var current_scale: int = 2

@export var jump_force:float = 200
var fall_speed:float = 5
var max_fall_speed:float = 200

var last_dist: float

func _ready() -> void:
	velocity.x = move_speed

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		print("jump")
		velocity.y = -jump_force
	elif event.is_action_pressed("scale_up"):
		scale_up()
	elif event.is_action_pressed("scale_down"):
		scale_down()
		

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if velocity.y != max_fall_speed:
			velocity.y += fall_speed
	elif velocity.y > 5:
		velocity.y = 0
	
	velocity.x = Input.get_axis("move_left","move_right") * move_speed
	
	if velocity.x:
		animations.play("walk")
		if velocity.x < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	else:
		animations.play("idle")
		
	
	
	
	move_and_slide()

func scale_up():
	#TODO: check for blocking roof
	if current_scale == 1:
		scale_animations.play_backwards("normal_to_small")
	else:
		return
		
	current_scale += 1
	
func scale_down():
	#animations
	if current_scale == 2:
		scale_animations.play("normal_to_small")
	else: 
		return
	
	current_scale -= 1
	
