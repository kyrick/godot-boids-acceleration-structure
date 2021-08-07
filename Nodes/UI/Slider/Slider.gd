extends MarginContainer

export var parameter := "cohesion"
export var group := "boids"
export(int) var initial_value: = 1
export(int) var min_value: = 0
export(int) var max_value: = 10

func _ready() -> void:
	$VBoxContainer/HBoxContainer/HSlider.min_value = min_value
	$VBoxContainer/HBoxContainer/HSlider.max_value = max_value
	$VBoxContainer/HBoxContainer/HSlider.value = initial_value
	
	$VBoxContainer/HBoxContainer/SpinBox.min_value = min_value
	$VBoxContainer/HBoxContainer/SpinBox.max_value = max_value
	$VBoxContainer/HBoxContainer/SpinBox.value = initial_value
	
	$VBoxContainer/Label.text = parameter.capitalize()

func _on_value_changed(value: float) -> void:
	get_tree().call_group(group, "set_"+parameter, value)

func get_value():
	return $VBoxContainer/HBoxContainer/HSlider.value

func _on_SpinBox_value_changed(value: float) -> void:
	_on_value_changed(value)
	$VBoxContainer/HBoxContainer/HSlider.value = value
	# prevent further keyboard input from being placed inside spinbox
	$VBoxContainer/HBoxContainer/HSlider.grab_focus()

func _on_HSlider_value_changed(value: float) -> void:
	_on_value_changed(value)
	$VBoxContainer/HBoxContainer/SpinBox.value = value
