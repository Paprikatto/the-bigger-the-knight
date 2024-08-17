extends PathFollow2D


@export var speed: float = 60

var speed_decrease_on_game_over: int = 20
var gameover: bool = false

func _ready() -> void:
	GameManager.game_over.connect(on_game_over)

func _process(delta: float) -> void:
	progress += speed * delta
	
	if gameover:
		if speed > 0:
			speed -= speed_decrease_on_game_over * delta
		else: 
			speed = 0

func on_game_over():
	gameover = true
