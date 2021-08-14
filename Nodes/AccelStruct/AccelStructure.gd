extends Node

var _cells: Array
var _scale: int
var size: Vector2

func _init(unscaled_size: Vector2, scale: int):
	_scale = scale

	size = Vector2(_scale_axis(unscaled_size.x), _scale_axis(unscaled_size.y))

	_cells = range(size.x + 1)
	
	for x in range(_cells.size()):
		_cells[x] = range(size.y + 1)
		for y in _cells[x].size():
			_cells[x][y] = []


func _scale_axis(point: float) -> int:
	return int(floor(point / _scale))


func scale_point(vector: Vector2) -> Vector2:
	var scaled_point = (vector / _scale).floor()
	scaled_point.x = min(max(scaled_point.x, 0), size.x)
	scaled_point.y = min(max(scaled_point.y, 0), size.y)
	return scaled_point


func add_body(body: Node2D, scaled_point: Vector2) -> void:
	_cells[scaled_point.x][scaled_point.y].append(body)


func get_bodies(scaled_point: Vector2):
	# keep the points in bounds
	var x = min(max(scaled_point.x, 0), size.x)
	var y = min(max(scaled_point.y, 0), size.y)
	
	var bodies = [_cells[x][y]]
	
	var up = y - 1
	var down = y + 1
	var left = x - 1
	var right = x + 1

	# up
	if up > 0:
		bodies.append(_cells[x][up])
		if left > 0:
			bodies.append(_cells[left][up])
		if right <= size.x:
			bodies.append(_cells[right][up])
	# down
	if down <= size.y:
		bodies.append(_cells[x][down])
		if left > 0:
			bodies.append(_cells[left][down])
		if right <= size.x:
			bodies.append(_cells[right][down])
	
	# left and right
	if left > 0:
		bodies.append(_cells[left][y])
	if right <= size.x:
		bodies.append(_cells[right][y])
	
	return bodies
