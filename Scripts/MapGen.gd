extends TileMapLayer

var rng = RandomNumberGenerator.new()

class Room:
		var rect: Rect2
		var center: Vector2
		func _init(x: int, y: int, w: int, h: int):
			rect = Rect2(x, y, w, h)
			center = rect.position + rect.size / 2.

var rooms = []
@export var roomCount = 5
var start = randi_range(0,1)

#X is min, Y is max
@export var posRange = Vector2i(0, 100)
@export var minRoomOffset = 10
@export var hallWidth = 3

var roomTiles:Array
var holder = hallWidth

var customRoomAtlas:Array
var customPos = Vector2(rng.randi_range(posRange.x, posRange.y), rng.randi_range(posRange.x, posRange.y))
var customSize = Vector2i()
var arr:Array
var customRoomPlaced = true
var customRoomCenter

func generate_roomsPoints(map:TileMapLayer, roomNumber:int, minSize:int, maxSize:int, debugLines:bool, customRoom:bool, roomName:String):
	#generate room positions and sizes
	var customRoomArray:Array

	for i in roomNumber:
		if i == 0:
			if customRoom:
				customRoomArray.append(1)
			else:
				customRoomArray.append(0)
		else:
			customRoomArray.append(0)
	print(customRoomArray)
	for i in customRoomArray:
		if i == 0:
			var overflowCount = 0
			while overflowCount <= 100:
				var size = Vector2(rng.randi_range(minSize, maxSize), rng.randi_range(minSize, maxSize))
				var pos = Vector2(rng.randi_range(posRange.x, posRange.y), rng.randi_range(posRange.x, posRange.y)) # Adjust range as needed
				var new_room = Room.new(pos.x, pos.y, size.x, size.y)
				if !room_overlaps(new_room):
					rooms.append(new_room)
					break
				else:
					overflowCount+=1
		if i == 1:
			while !customRoomPlaced:
				customRoomImport(roomName)
				var pos = customPos
				var new_room = Room.new(pos.x, pos.y, 0, 0)
				if !room_overlaps(new_room):
					rooms.append(new_room)
					customRoomPlaced = true
	#check for overlaps
		
	# ============= ༼ つ ◕_◕ ༽つ ============= #
	var edges = delauney()
	var mst = generateMst(edges)
	halls(mst, 2, map)
	halls(mst, 0, map)
	roomGen(map)
	Globals.mapGen.emit()
	#debugLineGen(mst, debugLines)
func roomGen(map):
	# Wall Gen
	for room in rooms:
		if room.rect.size != Vector2():
			var pos = room.rect.position
			var size = Vector2(room.rect.size.x +2, room.rect.size.y +2)
			for h in range(size.x):
				for k in range(size.y):
					if map.get_cell_source_id(Vector2i(pos.x+h,pos.y+k)) == -1:
						map.set_cell(Vector2i(pos.x+h,pos.y+k), 0, Vector2i(1,0))
	print(rooms)
	
	# Floor Gen
	for room in rooms:
		if room.rect.size != Vector2():
			var pos = Vector2(room.rect.position.x +1, room.rect.position.y+1)
			var size = room.rect.size
			for h in range(size.x):
				for k in range(size.y):
					map.set_cell(Vector2i(pos.x+h,pos.y+k), 0, Vector2i(0,0))
					if k != 0:
						roomTiles.append(Vector2i(pos.x+h,pos.y+k))
		Globals.openTiles += roomTiles

# Check for overlapping rooms
func room_overlaps(new_room: Room) -> bool:
	for room in rooms:
		var expanded = room.rect.grow(minRoomOffset)
		if expanded.intersects(new_room.rect.grow(minRoomOffset)):
			return true
	return false
# Do tranglation
func delauney():
	#get room centers, then triangulate
	var centers = PackedVector2Array()
	for room in rooms:
		centers.append(room.center)
	#Returns triangles by the index of the point in the table
	var triangulation = Geometry2D.triangulate_delaunay(centers)
	
	#Get all edges
	var edges = []
	for i in range(len(triangulation)/3.0):
		edges.append([triangulation[i*3],triangulation[(i*3)+1]])
		edges.append([triangulation[i*3+1],triangulation[(i*3)+2]])
		edges.append([triangulation[i*3+2],triangulation[(i*3)]])
	return edges
# Make the minimum spanning tree
func findMst(v,disjointSet):
	while disjointSet[v] != v:
		v = disjointSet[v]
	return v
func union(a,b,disjointSet):
	disjointSet[findMst(a,disjointSet)] = findMst(b,disjointSet)
# Creates the MST
func generateMst(edges):
	var mst = []
	var sortedEdges = []
	for i in edges:
		#Get the rooms and append their center
		sortedEdges.append([ rooms[ i[ 0 ] ].center, rooms[ i[ 1 ] ].center ])
	#sort edges by their length
	sortedEdges.sort_custom(func(a,b): return a[0].distance_to(a[1]) < b[0].distance_to(b[1]))
	
	var disjointSet = {}
	for room in rooms:
		disjointSet[room.center] = room.center

	for edge in sortedEdges:
		var a = edge[0]
		var b = edge[1]
		if findMst(a,disjointSet) != findMst(b,disjointSet):
			mst.append(edge)
			union(a,b,disjointSet)
	return mst
# Use MST to dig halls
func halls(mst, mod, map):
	#rng to vary hallway direction
	hallWidth = holder
	hallWidth += mod
	for line in mst:
		var yDir = 1
		var yStart
		#If first point below the second, change range iterate direction
		#This part makes the hallway have a full corner
		var firstY =line[0].y
		var lastY = line[1].y
		if firstY > lastY:
			firstY += (hallWidth-1)/2
			yDir = -1
		else:
			firstY -= (hallWidth-1)/2
		if start==0:
			yStart = line[0].x
		else:
			yStart = line[1].x
		
		#Dig vertical halls
		for vert in range(firstY, lastY, yDir):
			for i in range(hallWidth):
				if mod == 0:
					map.set_cell(Vector2i(yStart-(hallWidth-1)/2+i, vert), 0, Vector2i(0,0))
				else:
					map.set_cell(Vector2i(yStart-(hallWidth-1)/2+i, vert), 0, Vector2i(1,0))

		#same for horizontals
		var xDir = 1
		#This part makes the hallway have a full corner
		var firstX =line[0].x
		var lastX = line[1].x
		if firstX > lastX:
			firstX += (hallWidth-1)/2
			xDir = -1
		else:
			firstX -= (hallWidth-1)/2
			
		var xStart
		if start==0:
			xStart = line[1].y
		else:
			xStart = line[0].y
		
		for hor in range(firstX, lastX, xDir):
			for i in range(hallWidth):
				if mod == 0:
					map.set_cell(Vector2i(hor, xStart-(hallWidth-1)/2+i), 0, Vector2i(0,0))
				else:
					map.set_cell(Vector2i(hor, xStart-(hallWidth-1)/2+i), 0, Vector2i(1,0))
		### Place Custom Room ###
		for e in customRoomAtlas:
			if map.get_cell_atlas_coords(Vector2i(int(e[0].x) - customRoomCenter.x, int(e[0].y) - customRoomCenter.y)) != Vector2i(0, 0):
				map.set_cell(Vector2i(int(e[0].x) - customRoomCenter.x, int(e[0].y) - customRoomCenter.y), 0, Vector2i(int(e[1].x), int(e[1].y)))
# Cool line generator
func debugLineGen(mst, enableRoomDebugLines):
	if enableRoomDebugLines:
		for line in mst:
			var trace = Line2D.new()
			add_child(trace)
			trace.add_point(line[0]*64)
			trace.add_point(line[1]*64)
func customRoomImport(roomName):
	var s
	var cord:Vector2i
	var roomData = str_to_var(FileAccess.get_file_as_string("res://Rooms/" + roomName + ".json"))
	s = ((roomData.get("Pos").erase(0).erase(roomData.get("Pos").length()).split(", ")))
	customRoomCenter = Vector2i(int(s[0]), int(s[1]))
	arr = roomData.get("_Data")
	for i in arr:
		for g in i:
			for e in g:
				if e == "c":
					cord = strToVector(g) + Vector2i(customPos.x, customPos.y)
				if e == "a":
					customRoomAtlas.append([cord, strToVector(g)])
					break
	#customSize = str_to_var(roomData.get("Size").erase(0).erase(length(roomData.get("Size").split(", "))
	s = ((roomData.get("Size").erase(0).erase(roomData.get("Size").length()).split(", ")))
	customSize = Vector2i(int(s[0]), int(s[1]))
func strToVector(string):
	var raw = (string.erase(0).erase(string.length()).split(", "))
	return(Vector2i(int(raw[0]), int(raw[1])))
