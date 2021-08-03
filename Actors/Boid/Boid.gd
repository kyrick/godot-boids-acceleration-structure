extends Node2D

export var max_speed: = 200.0
export var mouse_follow_force: = 0.05
export var cohesion_force: = 0.05
export var algin_force: = 0.05
export var separation_force: = 0.05
export(float) var view_distance: = 50.0
export(float) var avoid_distance: = 20.0

onready var screen_size = get_viewport_rect().size

var _mouse_target: Vector2
var velocity: Vector2

var _accel_struct
var scaled_pos
var _flock_size: int = 0

func _ready():
	randomize()
	velocity = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized() * max_speed
	_mouse_target = get_random_target()


func _input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == BUTTON_LEFT:
			_mouse_target = event.position
		elif event.get_button_index() == BUTTON_RIGHT:
			_mouse_target = get_random_target()

func process(delta):
	position += velocity * delta
	wrap_screen()

	var flock = _accel_struct.get_bodies(scaled_pos, velocity)

	var mouse_vector = global_position.direction_to(_mouse_target) * mouse_follow_force

	# get cohesion, alginment, and separation vectors
	var vectors = get_flock_status(flock)
	
	# steer towards vectors
	var cohesion_vector = vectors[0] * cohesion_force
	var align_vector = vectors[1] * algin_force
	var separation_vector = vectors[2] * separation_force
	_flock_size = vectors[3]

	var acceleration = align_vector + max_speed * (cohesion_vector + separation_vector + mouse_vector)
	
	velocity = (velocity + acceleration).clamped(max_speed)

func get_flock_status(flock: Array):
	var center_vector: = Vector2()
	var flock_center: = Vector2()
	var align_vector: = Vector2()
	var avoid_vector: = Vector2()
	var flock_size: = 0

	for cell in flock:
		for f in cell:
			if f != self:
				var neighbor_pos: Vector2 = f.position
		
				if position.distance_to(neighbor_pos) < view_distance:
					flock_size += 1
					align_vector += f.velocity
					flock_center += neighbor_pos
			
					var d = position.distance_to(neighbor_pos)
					if d != 0 and d < avoid_distance:
						avoid_vector -= (neighbor_pos - position).normalized() * (avoid_distance / d)

	if flock_size:
		align_vector /= flock_size
		flock_center /= flock_size

		var center_dir = position.direction_to(flock_center)
		var center_speed = (position.distance_to(flock_center) / view_distance)
		center_vector = center_dir * center_speed

	return [center_vector, align_vector, avoid_vector, flock_size]


func get_random_target():
	randomize()
	return Vector2(rand_range(0, screen_size.x), rand_range(0, screen_size.y))


func wrap_screen():
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
