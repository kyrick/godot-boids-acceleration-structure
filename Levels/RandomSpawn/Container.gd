extends Container

const Flag = preload("res://Actors/MarkerFlag/MarkerFlag.tscn")

func _on_Container_gui_input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == BUTTON_LEFT:
			var flag = Flag.instance()
			flag.position = event.position
			$Flags.add_child(flag)
			get_tree().call_group("boids", "add_target", event.position)
		elif event.get_button_index() == BUTTON_RIGHT:
			for flag in $Flags.get_children():
				flag.queue_free()
			get_tree().call_group("boids", "clear_targets")
