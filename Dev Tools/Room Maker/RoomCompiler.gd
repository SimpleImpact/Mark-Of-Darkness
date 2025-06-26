extends Node2D

@onready var tilemap = $TileMapLayer
@onready var tile = $TileMapLayer.get_tile_set()
var room:Array
var path = "res://Rooms/tmp/"
var dim = Vector2(11, 11)
var use = 0
var center:Vector2
var export = true
var fileName:String
###  Tile Cords           Atlas Cords
#               \        /
### Outputs [[c1, 0), a0, 0)], [c2, 0), a0, 1)], ...]

func _ready() -> void:
	for r in dim.x:
		for e in dim.y:
			var index = tilemap.get_cell_atlas_coords(Vector2i(e, r))
			if index != Vector2i(-1, -1):
				room.append(["c" + str(int(e)) + ", " + str(int(r)) +")", "a" + str(index.x) + ", " + str(index.y) +")"])
				use += 1
				center.x += r
				center.y += e
	center = Vector2(round(center.x / use), round(center.y / use))
	var ID = 0
	
	### --- IMPORTANT --- ###
	export = true
	fileName = "Circle"
	
	if export:
		var recent:String
		var n = 0 #             Room name v
		var file = FileAccess.open(path + fileName + ".json", FileAccess.WRITE)
		var roomData = room
		### Tileset Info - 0, Room Center - 1, Tile Locations & Atlas Cords - 2
		var jsonString = JSON.stringify({"TileSet": tile, "Pos": center, "_Data": roomData, "Size": dim})
		if file:
			file.store_string(jsonString)
			file.close()
			print("Room saved succsefully")
		else:
			print("There was an error saving the room!")
