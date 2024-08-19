extends PathFollow2D


@export var speed: float = 60
@export var slow_down_areas: Array[SlowDownArea]

var in_area: bool = false
var next_area: int = -1

var speed_decrease_on_game_over: int = 20
var gameover: bool = false

func _ready() -> void:
	GameManager.game_over.connect(on_game_over)
	
	if not slow_down_areas.is_empty():
		next_area = 0

func _process(delta: float) -> void:
	if next_area != -1:
		if not in_area:
			if progress > slow_down_areas[next_area].start:
				in_area = true
		else:
			if progress > slow_down_areas[next_area].stop:
				in_area = false
				if slow_down_areas.size() > next_area+1:
					next_area += 1
				else:
					next_area = -1
	if in_area:
		progress += speed * delta * slow_down_areas[next_area].speed_factor
	else:
		progress += speed * delta
	
	
	if gameover:
		if speed > 0:
			speed -= speed_decrease_on_game_over * delta
		else: 
			speed = 0

func on_game_over():
	gameover = true
