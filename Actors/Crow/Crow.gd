extends "res://Actors/Boid/Boid.gd"

func _process(_delta):
	look_at(global_position + _velocity)
