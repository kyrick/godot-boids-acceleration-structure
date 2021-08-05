extends "res://Actors/Boid/Boid.gd"

var _highlight = 0.0

func _process(_delta):
	look_at(global_position + velocity)
	
	if _flock_size and _highlight < _flock_size / 10.0:
		_highlight += _flock_size / 1000.0
	elif _highlight > 0:
		_highlight -= 0.01

	$Sprite.modulate = Color(0, _highlight, 0)
