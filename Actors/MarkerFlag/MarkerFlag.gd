extends Node2D


func _init():
	visible = false


func _input(event):
	# disable for now
	return
	if event is InputEventMouseButton:
		if event.get_button_index() == BUTTON_LEFT:
			visible = true
			position = event.position
		elif event.get_button_index() == BUTTON_RIGHT:
			visible = false
