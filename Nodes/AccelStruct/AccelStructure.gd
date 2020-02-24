extends Node

var _cells: Array
var _scale: int
var _map: Dictionary = {}

var x_min: int
var x_max: int
var y_min: int
var y_max: int

func _init(bounds: Rect2, scale: int):
	_scale = scale

	x_min = _scale_axis(bounds.position.x)
	x_max = _scale_axis(bounds.end.x)
	y_min = _scale_axis(bounds.position.y)
	y_max = _scale_axis(bounds.end.y)
	
	_cells = range(x_min, x_max + 1)
	
	for x in range(_cells.size()):
		_cells[x] = range(y_min, y_max + 1)
		for y in _cells[x].size():
			_cells[x][y] = []


func _scale_axis(point: float) -> int:
	return int(floor(point / _scale))


func _scale_point(vector: Vector2) -> Vector2:
	return(vector / _scale).floor()


func _get_body_position(body: Node2D) -> Vector2:
	return body.position


func add_body(body: Node2D) -> void:
	
	var center: = _get_body_position(body)
	var scaled_point: = _scale_point(center)
	
	if scaled_point.x < x_min:
		scaled_point.x = x_min
	elif scaled_point.x > x_max:
		scaled_point.x = x_max
	
	if scaled_point.y < y_min:
		scaled_point.y = y_min
	elif scaled_point.y > y_max:
		scaled_point.y = y_max
	
	_map[body.name] = scaled_point
	_cells[int(scaled_point.x)][int(scaled_point.y)].append(body)


func update_body(body: Node2D) -> void:
	var prev_point: Vector2 = _map[body.name]
	
	var scaled_point: = _scale_point(_get_body_position(body))
	
	if prev_point.x != scaled_point.x or prev_point.y != scaled_point.y:
		var loc: int = _cells[prev_point.x][prev_point.y].find(body)
		_cells[prev_point.x][prev_point.y].remove(loc)
		add_body(body)


func get_bodies(body: Node2D):
	var center: = _get_body_position(body)
	var point: = _scale_point(center)

	var x = point.x
	if x < x_min:
		x = x_min
	elif x > x_max:
		x = x_max
	var y = point.y
	if y < y_min:
		y = y_min
	elif y > y_max:
		y = y_max
	
	var bodies = _cells[x][y]
	if x - 1 >= x_min:
		bodies += _cells[x - 1][y]
	if x + 1 <= x_max:
		bodies += _cells[x + 1][y]
	if y - 1 >= y_min:
		bodies += _cells[x][y - 1]
	if y + 1 <= y_max:
		bodies += _cells[x][y + 1]
	
	return bodies
