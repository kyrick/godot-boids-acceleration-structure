extends Node2D

const AccelStruct = preload("res://Nodes/AccelStruct/AccelStructure.gd")

export(int) var boids = 20
export(PackedScene) var Boid
export(int) var struct_scale = 10 

var _width = ProjectSettings.get_setting("display/window/size/width")
var _height = ProjectSettings.get_setting("display/window/size/height")
var _accel_struct: AccelStruct

func _ready():
	var bounds = Rect2(Vector2(0, 0), Vector2(_width, _height))
	_accel_struct = AccelStruct.new(bounds, struct_scale)
	
	for _i in range(boids):
		randomize()
		var boid = Boid.instance()
		var init_pos: = Vector2(rand_range(0, _width), rand_range(0, _height))
		boid.position = init_pos
		var scaled = _accel_struct.scale_point(init_pos)
		boid._prev_point = scaled
		_accel_struct.add_body(boid, scaled)
		boid._accel_struct = _accel_struct
		add_child(boid)


#func _physics_process(_delta):
#	for boid in _boids:
#		_accel_struct.update_body(boid)
#		var flock = _accel_struct.get_bodies(boid, boid.view_distance)
#		boid.set_flock(flock)
		
