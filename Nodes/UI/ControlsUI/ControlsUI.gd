extends Control

func get_current_values() -> Dictionary:
	var values = {}
	for control in $Sliders.get_children():
		values[control.parameter] = control.get_value()
	return values

func reset():
	for control in $Sliders.get_children():
		control.reset()
