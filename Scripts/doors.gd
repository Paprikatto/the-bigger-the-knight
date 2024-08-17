extends Node


var connected_buttons: Array[RedButton]
var buttons_clicked = 0

func _ready() -> void:
	for b in connected_buttons:
		b.pressed.connect(on_button_click)
func on_button_click():
	buttons_clicked += 1
	if buttons_clicked == connected_buttons.size():
		#TODO opening doors
		pass
