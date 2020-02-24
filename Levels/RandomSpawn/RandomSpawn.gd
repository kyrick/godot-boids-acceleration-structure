extends Node2D

const AccelStruct = preload("res://Nodes/AccelStruct/AccelStructure.gd")

export(int) var boids = 20
export(PackedScene) var Boid
export(int) var struct_scale = 10 

var _width = ProjectSettings.get_setting("display/window/size/width")
var _height = ProjectSettings.get_setting("display/window/size/height")
var _boids: Array
var _accel_struct: AccelStruct

func _ready():
	var bounds = Rect2(Vector2(0, 0), Vector2(_width, _height))
	_accel_struct = AccelStruct.new(bounds, struct_scale)
	
	for _i in range(boids):
		randomize()
		var boid = Boid.instance()
		boid._accel_struct = _accel_struct
		boid.position = Vector2(rand_range(0, _width), rand_range(0, _height))
		add_child(boid)
		_boids.append(boid)
		_accel_struct.add_body(boid)


#func _physics_process(_delta):
#	for boid in _boids:
#		_accel_struct.update_body(boid)
#		var flock = _accel_struct.get_bodies(boid, boid.view_distance)
#		boid.set_flock(flock)
		
