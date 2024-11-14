extends Node2D

@export var texture : Texture2D
@export var tilesize : Vector2i
var gridsize : Vector2i
var tiles : Array[SwapTile]
var tilect : int
var hoveri : int

class SwapTile:
	var frame:int
	var cell:Vector2i
	func _init(frame:int,cell:Vector2i) -> void:
		self.frame=frame
		self.cell=cell
	func swapwith(other:SwapTile) -> void:
		var other_frame = other.frame
		other.frame = frame
		frame = other_frame

func _ready() -> void:
	gridsize = texture.get_size() as Vector2i / tilesize
	tiles.append(SwapTile.new())
	tilect += 1

func pos_to_idx(pos:Vector2) -> int:
	if pos.x < 0: return -1
	if pos.y < 0: return -1
	var cell : Vector2i = pos as Vector2i / tilesize
	if cell.x >= gridsize.x: return -1
	if cell.y >= gridsize.y: return -1
	return cell.x + cell.y * gridsize.x
func idx_to_cell(idx:int) -> Vector2i:
	@warning_ignore("integer_division")
	return Vector2i(
		idx%gridsize.x,
		idx/gridsize.x
	)

func _physics_process(_delta: float) -> void:
	var m_pos = get_local_mouse_position()
	var m_idx : int = pos_to_idx(m_pos)
	hoveri = m_idx
	queue_redraw()

func _draw() -> void:
	var rpos : Rect2 = Rect2(Vector2.ZERO, tilesize as Vector2)
	var rsrc : Rect2 = Rect2(Vector2.ZERO, tilesize as Vector2)
	for tile in tiles:
		rpos.position = tile.pos
		rsrc.position = tile.src
		draw_texture_rect_region(texture, rpos, rsrc)
		if tile.i == draggi: draw_rect(rpos, Color(1,1,1,0.24))
		if tile.i == hoveri: draw_rect(rpos, Color(1,1,1,0.12))
