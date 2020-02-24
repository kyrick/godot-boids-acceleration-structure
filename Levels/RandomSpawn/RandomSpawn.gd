extends Node2D

const AccelStruct = preload("res://Nodes/AccelStruct/AccelStructure.gd")

export(int) var boids = 20
export(PackedScene) var Boid
export(int) var struct_scale = 10 

onready var screen_rect: = get_viewport_rect()

var _accel_struct: AccelStruct

func _ready():
	_accel_struct = AccelStruct.new(screen_rect, struct_scale)
	
	for _i in range(boids):
		randomize()
		var boid = Boid.instance()
		var screen_size = screen_rect.size
		var init_pos: = Vector2(rand_range(0, screen_size.x), rand_range(0, screen_size.y))
		boid.position = init_pos
		var scaled = _accel_struct.scale_point(init_pos)
		boid._prev_point = scaled
		_accel_struct.add_body(boid, scaled)
		boid._accel_struct = _accel_struct
		add_child(boid)
