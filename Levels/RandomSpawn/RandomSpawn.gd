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
	
	for _i in compute_groups:
		# define the compute groups as separate arrays
		boids.append([])
	
	for i in range(max_boids):
		randomize()
		var boid = Boid.instance()
		var init_pos: = Vector2(rand_range(0, screen_size.x), rand_range(0, screen_size.y))
		boid.position = init_pos
		var scaled_pos = _accel_struct.scale_point(init_pos)
		_accel_struct.add_body(boid, scaled_pos)
		boid._accel_struct = _accel_struct
		boid.scaled_pos = scaled_pos
		add_child(boid)
		
		# add this bar to a compute group
		var compute_group = wrapi(i, 0, compute_groups)
		boids[compute_group].append(boid)


func _process(delta):
	_accel_struct = AccelStruct.new(screen_size, struct_scale)
	
	for group in boids:
		for boid in group:
			var scaled_pos = _accel_struct.scale_point(boid.position)
			_accel_struct.add_body(boid, scaled_pos)
			boid._accel_struct = _accel_struct
			boid.scaled_pos = scaled_pos
	
#	var threads = []
	
	for group in boids:
#		var thread = Thread.new()
#		thread.start(self, "process_group", [delta, group])
		process_group([delta, group])
	
#	for t in threads:
#		t.wait_to_finish()


func process_group(userdata):
	var delta = userdata[0]
	var group = userdata[1]
	for boid in group:
		boid.process(delta)
	
