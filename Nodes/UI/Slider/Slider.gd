extends MarginContainer

export var parameter := "cohesion"
export var group := "boids"
export(int) var initial_value: = 1
export(int) var min_value: = 0
export(int) var max_value: = 10
export(float) var scale_by: = 1.0

onready var _value: float = initial_value * scale_by


func _ready() -> void:
	$VBoxContainer/HBoxContainer/HSlider.min_value = min_value
	$VBoxContainer/HBoxContainer/HSlider.max_value = max_value
	
	$VBoxContainer/HBoxContainer/SpinBox.min_value = min_value
	$VBoxContainer/HBoxContainer/SpinBox.max_value = max_value

	$VBoxContainer/Label.text = parameter.capitalize()
	
	set_initial_value()


func _on_value_changed(value: float) -> void:
	_value = value * scale_by
	get_tree().call_group(group, "set_"+parameter, _value)


func get_value():
	return _value


func reset():
	set_initial_value()


func set_initial_value():
	_value = initial_value * scale_by
	$VBoxContainer/HBoxContainer/HSlider.value = initial_value
	$VBoxContainer/HBoxContainer/SpinBox.value = initial_value


func _on_SpinBox_value_changed(value: float) -> void:
	_on_value_changed(value)
	$VBoxContainer/HBoxContainer/HSlider.value = value
	# prevent further keyboard input from being placed inside spinbox
	$VBoxContainer/HBoxContainer/HSlider.grab_focus()


func _on_HSlider_value_changed(value: float) -> void:
	$VBoxContainer/HBoxContainer/SpinBox.value = value
	_on_value_changed(value)
