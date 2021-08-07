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
	return(vector / _scale).floor()


func add_body(body: Node2D, scaled_point: Vector2) -> void:
	_cells[scaled_point.x][scaled_point.y].append(body)


func get_bodies(scaled_point: Vector2):
	var x = scaled_point.x
	var y = scaled_point.y
	
	var bodies = [_cells[x][y]]
	
	var up = wrapi(y - 1, 0, size.y)
	var down = wrapi(y + 1, 0, size.y)
	var left = wrapi(x - 1, 0, size.x)
	var right = wrapi(x + 1, 0, size.x)

	# up
	bodies.append(_cells[x][up])
	bodies.append(_cells[left][up])
	bodies.append(_cells[right][up])
	# down
	bodies.append(_cells[x][down])
	bodies.append(_cells[left][down])
	bodies.append(_cells[right][down])
	
	# left and right
	bodies.append(_cells[left][y])
	bodies.append(_cells[right][y])
	
	return bodies
