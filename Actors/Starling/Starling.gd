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

	var angle_highlight = (rad2deg(velocity.angle_to_point(to_local(Vector2.ZERO))) + 180) / 360
	var neg_angle = 1-angle_highlight

	var glow_highlight = flock_highlight/100
	$Glow.modulate = Color.from_hsv(angle_highlight, 1, 1, glow_highlight)
	$Sprite.modulate = Color.from_hsv(angle_highlight, 1, 1)

#	var distance_highlight = (max_distance - global_position.distance_to(middle_screen))/ max_distance
#	$Sprite.modulate = Color(distance_highlight,
#							 1-distance_highlight/2, 
#							 1-distance_highlight,
#							 flock_highlight)

func _unhandled_input(event: InputEvent):
	if event.is_action_released("toggle_view_radius"):
		$Glow.visible = not $Glow.visible
	
