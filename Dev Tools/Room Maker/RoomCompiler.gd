extends Node2D

@onready var tilemap = $TileMapLayer
var room:Array
###  Tile Cords           Atlas Cords
#               \        /
### Outputs [[c1, 0), a0, 0)], [c2, 0), a0, 1)], ...]

func _ready() -> void:
	for r in 8:
		for e in 8:
			var index = tilemap.get_cell_atlas_coords(Vector2i(e, r))
			if index != Vector2i(-1, -1):
				room.append(["c" + str(e) + ", " + str(r) +")", "a" + str(index.x) + ", " + str(index.y) +")"])
	print(room)

	
func printThis(x):
	print(x)
