extends Container


func _on_Container_gui_input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == BUTTON_LEFT:
			$Flag.visible = true
			$Flag.position = event.position
			get_tree().call_group("boids", "set_target", event.position)
		elif event.get_button_index() == BUTTON_RIGHT:
			$Flag.visible = false
			get_tree().call_group("boids", "clear_target")
