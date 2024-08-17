extends Camera2D


@export var target: Node2D
var speed: float = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dist = abs(global_position.x - target.global_position.x)
	
	global_position.x = move_toward(global_position.x, target.global_position.x, dist * speed)
	
