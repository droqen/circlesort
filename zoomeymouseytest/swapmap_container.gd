extends Node2D

func _ready() -> void:
	texture_filter = TEXTURE_FILTER_NEAREST

func _physics_process(_delta: float) -> void:
	var viewsize = get_viewport_rect().size
	scale = Vector2.ONE * max(1,floor(min(
		(viewsize.x-50) / $swapmap.mapsize.x,
		(viewsize.y-50) / $swapmap.mapsize.y
	)))
	position = (viewsize - $swapmap.mapsize * scale) * 0.5
	position.x = floor(position.x)
	position.y = floor(position.y)
	
