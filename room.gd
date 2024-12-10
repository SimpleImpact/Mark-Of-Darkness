extends Node

enum Tiles { EMPTY, SOLID }

var skeletonObject: PackedScene = preload("res://Enemies/Skeleton.tscn")

class Room:
	var position:Vector2
	var dimensions:Vector2
	var centerpoint:Vector2


var dugRooms = []
var rng = RandomNumberGenerator.new()

var mapWidth
var mapHeight

func _ready():
	rng.randomize()


func generate(map:TileMap, w:int, h:int, minRoomSize, maxRoomSize):
	
	var potentialRooms:int = (w / maxRoomSize) * (h / maxRoomSize)
	var rooms:Dictionary
	var room:Room
	var position:Vector2

	var start:Vector2
	var end:Vector2

	var modifier:int

	var key:String
	
	mapWidth = w
	mapHeight = h

	# Fill map with solid tiles, adding a "border" of solid tiles around the map
	# out of bounds.
	for r in range(-1, h + 1):
		for c in range (-1, w + 1):
			map.set_cell(0, Vector2i(c, r*2), 0, Vector2i(Tiles.SOLID, 0))
	
	# Generate potential rooms.
	for r in potentialRooms:
		position = Vector2(rng.randi_range(1, w - maxRoomSize), rng.randi_range(1, h - maxRoomSize))

		key = str(position.x) + " " + str(position.y)

		if (!rooms.has(key)):
			room = Room.new()

			room.position    = position
			room.dimensions  = Vector2(rng.randi_range(minRoomSize, maxRoomSize), rng.randi_range(minRoomSize, maxRoomSize))
			room.centerpoint = room.position + Vector2(room.dimensions.x / 2, room.dimensions.y / 2)

			rooms[key] = room

			digRoom(map, room)

	# Connect dug rooms.
	dugRooms = rooms.values().duplicate()
	
	for r in dugRooms.size() - 1:
		start = round(Vector2(dugRooms[r].centerpoint.x, dugRooms[r].centerpoint.y))
		end = round(Vector2(dugRooms[r + 1].centerpoint.x, dugRooms[r + 1].centerpoint.y))
		

		if (start.y < end.y):
			modifier = 1
		else:
			modifier = -1

		for row in range(start.y, end.y, modifier):
			digCell(map, round(Vector2(start.x, row)))

		if (start.x < end.x):
			modifier = 1
		else:
			modifier = -1

		for col in range(start.x, end.x, modifier):           
			digCell(map, Vector2(col, end.y))
			
	#-----------------------------------------------
	#------------ | Object Spawning | --------------
	#-----------------------------------------------
	var spawnableSpaces = map.get_used_cells(-1)
	print(len(spawnableSpaces))
	for i in spawnableSpaces:
		if true:
			var skeleton = skeletonObject.instantiate()
			skeleton.position = (map.map_to_local(i))
			add_child(skeleton)


func digRoom(map, room):
	for x in range(room.position.x, room.position.x + room.dimensions.x - 1):
		for y in range(room.position.y, room.position.y + room.dimensions.y - 1):
			digCell(map, Vector2(round(x), round(y)))


func digCell(map, pos):
	if ((pos.x < mapWidth) && (pos.y < mapHeight)):
		map.set_cell(0, Vector2i(pos.x, pos.y), -1, Vector2i(Tiles.EMPTY, 0))

func rand(minimum, maximum):
	return(rng.randi_range(minimum, maximum))
	
