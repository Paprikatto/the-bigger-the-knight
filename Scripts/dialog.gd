extends dialog_line
class_name dialog

@export var animation : AnimationPlayer

var timer : Timer

@export var label : Label

@export var dialogTable : Array[dialog_line]

var lastWho : Who

var i : int = 0
var numLetter = 0
var max : int
@export var letterDelay = .05

func _ready():
	timer = $Timer
	max = dialogTable.size()
	timer.start(letterDelay)
	
	if max > 0:
		label.text = dialogTable[i].text
		lastWho = dialogTable[i].who
		if dialogTable[i].who == Who.FIRST:
			animation.play("move_rev")
		else:
			animation.play("move")
		animation.seek(.4)
func _unhandled_input(event):
	if event is InputEventKey and event.is_pressed():
		i+=1
		numLetter = 0
		label.visible_characters = numLetter
		var sameSide = false
		if i >= max:
			GameManager.next_level.emit()
		else:
			if lastWho == dialogTable[i].who:
				sameSide = true
			lastWho = dialogTable[i].who
			if dialogTable[i].who == Who.FIRST and !sameSide:
				animation.play("move_rev")
			else:
				if !sameSide:
					animation.play("move")
			label.text = dialogTable[i].text


func _on_timer_timeout():
	if numLetter <= label.text.length():
		numLetter+=1
		label.visible_characters = numLetter
		timer.start(letterDelay)
			
