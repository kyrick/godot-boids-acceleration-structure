extends Node2D

export var show_grid = true

var struct_size: Vector2
var struct_scale: int

func _draw():
	if show_grid and struct_size != null: 
		for x in struct_size.x + 1:
			var start = Vector2(x * struct_scale, 0)
			var end = Vector2(x * struct_scale, struct_size.y * struct_scale)
			draw_line(start, end, Color.blue)
		for y in struct_size.y + 1:
			var start = Vector2(0, y * struct_scale)
			var end = Vector2(struct_size.x * struct_scale, y * struct_scale)
			draw_line(start, end, Color.blue)

func _process(_delta):
	if visible:
		update()
