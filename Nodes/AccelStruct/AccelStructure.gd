extends Node


class Point2:
	
	var x: int
	var y: int
	
	func _init(inst_x: int, inst_y: int):
		self.x = inst_x
		self.y = inst_y


class AccelStruct:
	
	var _bounds: Rect2
	var _zones: Array
	var _scale: int
	var _map: Dictionary = {}
	
	func _init(bounds: Rect2, scale: int):
		_bounds = bounds
		_scale = scale
		
		_zones = range(_scale_axis(_bounds.position.x), _scale_axis(_bounds.end.x))
		
		for x in range(_zones.size()):
			_zones[x] = range(_scale_axis(_bounds.position.y), _scale_axis(_bounds.end.y))
			for y in _zones[x].size():
				_zones[x][y] = []


	func _scale_axis(point: float) -> int:
		return int(floor(point / _scale))


	func _scale_point(vector: Vector2) -> Point2:
		var scaled = (vector / _scale).floor()
		return Point2.new(int(scaled.x), int(scaled.y))

	
	func _get_body_position(body: Node2D) -> Vector2:
		return body.global_position


	func add_body(body: Node2D) -> void:
		
		var this_point: = _get_body_position(body)
		var scaled_point = _scale_point(this_point)
		
		_map[body.name] = scaled_point
		_zones[int(scaled_point.x)][int(scaled_point.y)].append(body)


	func update_body(body: Node2D) -> void:
		var prev_point: Point2 = _map[body.name]
		
		var scaled_point: = _scale_point(_get_body_position(body))
		
		if prev_point != scaled_point:
			var loc: int = _zones[prev_point.x][prev_point.y].find(body)
			_zones[prev_point.x][prev_point.y].remove(loc)
			add_body(body)


	func get_bodies(body: Node2D, radius: float):
		var center: = _get_body_position(body)
		var point: = _scale_point(center)
		var r = _scale_axis(radius)

		var rx = range(point.x - r, point.x + r + 1)
		var ry = range(point.y - r, point.y + r + 1)
		
		var bodies = []
		for x in rx:
			for y in ry:
				bodies += _zones[x][y]
		
		return bodies
