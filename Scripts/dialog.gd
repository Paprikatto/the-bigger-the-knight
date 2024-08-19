extends dialog_line
class_name dialog

@export var first : Node
@export var second : Node

@export var label : Label

@export var dialogTable : Array[dialog_line]

var i : int = 0
var max : int

func _ready():
	max = dialogTable.size()
	
	if max > 0:
		label.text = dialogTable[i].text
		if dialogTable[i].who == Who.FIRST:
			first.visible = true
			second.visible = false
		else:
			first.visible = false
			second.visible = true

func _unhandled_input(event):
	if event is InputEventKey and event.is_pressed():
		i+=1
		
		if i >= max:
			#koniec cutscenki tutaj przejscie dalej
			GameManager.next_level.emit()
		else:
			if dialogTable[i].who == Who.FIRST:
				first.visible = true
				second.visible = false
			else:
				first.visible = false
				second.visible = true
				
			label.text = dialogTable[i].text
		
