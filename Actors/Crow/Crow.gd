extends "res://Actors/Boid/Boid.gd"

var flock_highlight = 0.0

onready var middle_screen = screen_size / 2
onready var max_distance = screen_size.distance_to(middle_screen)


func _process(_delta):
	look_at(global_position + velocity)
	
	if flock_size and flock_highlight < float(flock_size) / float(max_flock_size):
		flock_highlight += 0.01
	elif flock_highlight > 0:
		flock_highlight -= 0.01

	var angle_highlight = velocity.angle_to_point(Vector2.ZERO) / 6.28319
	var distance_highlight = (max_distance - global_position.distance_to(middle_screen))/ max_distance

	$Sprite.modulate = Color(0, flock_highlight, 0)

#	$Sprite.modulate = Color(angle_highlight,
#							 0, 
#							 distance_highlight,
#							 flock_highlight)
