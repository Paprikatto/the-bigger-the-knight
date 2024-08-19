extends dialog_line
class_name dialog

@export var first : Node
@export var second : Node

@export var label : Label

@export var dialogTable : Array[dialog_line]

var i : int = 0
var numLetter = 0
var max : int
@export var letterDelay = .05

func _ready():
	max_dialog = dialogTable.size()
	
	if max_dialog > 0:
		label.text = dialogTable[i].text
		if dialogTable[i].who == Who.FIRST:
			first.visible = true
			second.visible = false
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
			if dialogTable[i].who == Who.FIRST:
				first.visible = true
				second.visible = false
			else:
				first.visible = false
				second.visible = true
				
			label.text = dialogTable[i].text
		
