extends Node2D

const TILE_PREFAB = preload("res://tile.tscn")

var tiles : Array[Sprite2D]

var heldtile : Sprite2D = null

func _ready() -> void:
	var i : int = 0
	for y in range(10): for x in range(10):
		var tile : Sprite2D = TILE_PREFAB.instantiate()
		tile.position = Vector2(
			5 + 10 * x,
			5 + 10 * y
		)
		tile.frame = i
		add_child(tile)
		i += 1
		tiles.append(tile)
	for a in range(i-1):
		var b = randi_range(a,100-1)
		if a != b:
			swap(tiles[a],tiles[b])

func _physics_process(_delta: float) -> void:
	var m = get_global_mouse_position()
	var nearest_tile : Sprite2D = null
	var nearest_tdistsqr : float = 999
	for tile in tiles:
		var tdistsqr = tile.position.distance_squared_to(m)
		if tdistsqr < nearest_tdistsqr:
			nearest_tile = tile
			nearest_tdistsqr = tdistsqr
	for tile in tiles:
		if tile == nearest_tile:
			tile.modulate = Color(1.5,1.5,1.5)
		else:
			tile.modulate = Color.WHITE
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if heldtile == null:
			heldtile = nearest_tile
		elif heldtile != nearest_tile:
			swap(heldtile,nearest_tile)
	else:
		heldtile = null

func swap(a:Node2D,b:Node2D):
	var pa : Vector2 = a.position
	a.position = b.position
	b.position = pa;
