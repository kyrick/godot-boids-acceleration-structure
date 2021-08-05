extends Node2D

const AccelStruct = preload("res://Nodes/AccelStruct/AccelStructure.gd")

export(int) var max_boids = 20
export(PackedScene) var Boid
export(int) var struct_scale = 10 
export(int) var compute_groups = 4

onready var screen_size: = get_viewport_rect().size

var _accel_struct: AccelStruct
var boids = []

func _ready():
	_accel_struct = AccelStruct.new(screen_size, struct_scale)
	
	var scaled_points = range(max_boids)
	
	for i in range(max_boids):
		randomize()
		var boid = Boid.instance()
		var init_pos: = Vector2(rand_range(0, screen_size.x), rand_range(0, screen_size.y))
		boid.position = init_pos
		var scaled_point = _accel_struct.scale_point(init_pos)
		_accel_struct.add_body(boid, scaled_point)
		scaled_points[i] = scaled_point
		boids.append(boid)
		
	for i in range(max_boids):
		boids[i].flock = _accel_struct.get_bodies(scaled_points[i])
		add_child(boids[i])


func _process(delta):
#	var threads = []
#
#	for group in compute_groups:
#		var thread = Thread.new()
#		thread.start(self, "process_group", {"delta": delta, "group": group})
#		threads.append(thread)
	
	_accel_struct = AccelStruct.new(screen_size, struct_scale)

	var scaled_points = range(boids.size())

	for i in boids.size():
		var scaled_point = _accel_struct.scale_point(boids[i].position)
		_accel_struct.add_body(boids[i], scaled_point)
		scaled_points[i] = scaled_point

#	for t in threads:
#		t.wait_to_finish()
	
	for i in boids.size():
		boids[i].flock = _accel_struct.get_bodies(scaled_points[i])
	for group in compute_groups:
		process_group({"delta": delta, "group": group})


func process_group(data):
	var start = boids.size() / compute_groups * data.group
	var end = start + boids.size() / compute_groups
	# if the number of bodies is not divisible by num_threads,
	# add the remainder to the last thread
	if data.group == compute_groups - 1:
		end += boids.size() % compute_groups
	for i in range(start, end):
		boids[i].process(data.delta)
	
