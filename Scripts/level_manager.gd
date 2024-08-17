extends Node2D
class_name LevelManager

@export var current_level_index: int = 0
@export var levels: Array[PackedScene]

var current_level: Node2D

func _ready() -> void:
	current_level = levels[current_level_index].instantiate()
	self.add_child(current_level)

func restart_level():
	current_level.queue_free()
	current_level = levels[current_level_index].instantiate()
	self.add_child(current_level)
	
