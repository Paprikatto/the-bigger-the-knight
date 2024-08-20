extends Node2D
class_name dialog

@export var animation : AnimationPlayer

var timer : Timer

@export var label : Label

@export var dialogTable : Array[DialogLine]

var lastWho : DialogLine.Who

var i : int = 0
var numLetter = 0
var size : int
@export var letterDelay = .05

var whole_text_visible: bool = false

func _ready():
	timer = $Timer
	size = dialogTable.size()
	timer.start(letterDelay)
	
	if size > 0:
		label.text = dialogTable[i].text
		lastWho = dialogTable[i].who
		if dialogTable[i].who == DialogLine.Who.FIRST:
			animation.play("move_rev")
		else:
			animation.play("move")
		animation.seek(.4)

func _unhandled_input(event):
	var keyboard_input:bool = event is InputEventKey and event.is_pressed()
	var mouse_input:bool = event is InputEventMouseButton and event.is_pressed()
	if keyboard_input or mouse_input:
		if label.visible_characters == -1 or label.visible_characters >= label.text.length():
			i+=1
			numLetter = 0
			label.visible_characters = numLetter
			var sameSide = false
			if i >= size:
				GameManager.next_level.emit()
			else:
				if lastWho == dialogTable[i].who:
					sameSide = true
				lastWho = dialogTable[i].who
				if dialogTable[i].who == DialogLine.Who.FIRST and !sameSide:
					animation.play("move_rev")
				else:
					if !sameSide:
						animation.play("move")
				label.text = dialogTable[i].text
				print(label.text)
		else:
			label.visible_characters = -1
			numLetter = label.text.length()


func _on_timer_timeout():
	if numLetter <= label.text.length():
		numLetter+=1
		label.visible_characters = numLetter
		timer.start(letterDelay)
