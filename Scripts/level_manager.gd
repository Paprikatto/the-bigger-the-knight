extends Node2D
class_name LevelManager

@export var current_level_index: int = 0
@export var levels: Array[PackedScene]
@export var end_game_screen: PackedScene

var current_level: Node2D

func _ready() -> void:
	
	current_level = levels[current_level_index].instantiate()
	self.add_child(current_level)

func restart_level():
	current_level.queue_free()
	current_level = levels[current_level_index].instantiate()
	self.add_child(current_level)
	
func next_level():
	current_level.queue_free()
	current_level_index += 1
	if levels.size() > current_level_index:
		current_level = levels[current_level_index].instantiate()
	else:
		current_level = end_game_screen.instantiate()
	
	current_level.tree_entered.connect(level_loaded, CONNECT_ONE_SHOT)
	self.call_deferred("add_child",current_level)

func level_loaded():
	$NextLevelAnimation.play_anim(true)
		
