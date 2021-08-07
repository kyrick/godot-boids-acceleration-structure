extends Node2D

export(float) var max_speed: = 100.0
export(float) var min_speed: = 80.0
export(float) var target_force: = 2.0
export(float) var cohesion: = 2.0
export(float) var alignment: = 3.0
export(float) var separation: = 5.0
export(float) var view_distance: = 50.0
export(float) var avoid_distance: = 15.0
export(int) var max_flock_size: = 15

onready var screen_size = get_viewport_rect().size

var _mouse_target: Vector2
var velocity: Vector2
var mouse_follow = false

# a 2D array of "cells"
var flock = []
var flock_size: int = 0


func _ready():
	randomize()
	velocity = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized() * max_speed
	_mouse_target = get_random_target()


func _input(event):
	# disable for now
	return
	if event is InputEventMouseButton:
		if event.get_button_index() == BUTTON_LEFT:
			mouse_follow = true
			_mouse_target = event.position
		elif event.get_button_index() == BUTTON_RIGHT:
			mouse_follow = false


func process(delta):
	position += velocity * delta
	wrap_screen()

	# get cohesion, alginment, and separation vectors
	var vectors = get_flock_status()
	
	# steer towards vectors
	var cohesion_vector = vectors[0] * cohesion
	var align_vector = vectors[1] * alignment
	var separation_vector = vectors[2] * separation
	flock_size = vectors[3]

	var acceleration = align_vector + cohesion_vector + separation_vector
	if mouse_follow:
		var mouse_vector = global_position.direction_to(_mouse_target) * target_force
		acceleration += mouse_vector
	
	velocity = (velocity + acceleration).clamped(max_speed)
	if velocity.length() <= min_speed:
		velocity = (velocity * min_speed).clamped(max_speed)


func get_flock_status():
	var center_vector: = Vector2()
	var flock_center: = Vector2()
	var align_vector: = Vector2()
	var avoid_vector: = Vector2()
	var other_count: = 0

	for cell in flock:
		for other in cell:
			if other_count == max_flock_size:
				break

			if other == self:
				continue

			var other_pos: Vector2 = other.global_position
			var other_velocity: Vector2 = other.velocity
	
			if global_position.distance_to(other_pos) < view_distance:
				other_count += 1
				align_vector += other_velocity
				flock_center += other_pos
		
				var d = global_position.distance_to(other_pos)
				if d < avoid_distance:
					avoid_vector -= other_pos - global_position

	if other_count:
		align_vector /= other_count
		flock_center /= other_count

		center_vector = global_position.direction_to(flock_center)

	return [center_vector.normalized(),
			align_vector.normalized(), 
			avoid_vector.normalized(), 
			other_count]


func get_random_target():
	randomize()
	return Vector2(rand_range(0, screen_size.x), rand_range(0, screen_size.y))


func wrap_screen():
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)

func set_values(params: Dictionary):
	for param in params.keys():
		set(param, params[param])


func set_max_speed(value: float):
	max_speed = value

func set_min_speed(value:float):
	min_speed = value

func set_target_force(value:float):
	target_force = value

func set_cohesion(value:float):
	cohesion = value

func set_alignment(value:float):
	alignment = value

func set_separation(value:float):
	separation = value

func set_view_distance(value:float):
	view_distance = value

func set_avoid_distance(value:float):
	avoid_distance = value

func set_max_flock_size(value:float):
	max_flock_size = value
