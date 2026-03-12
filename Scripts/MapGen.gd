extends TileMapLayer

var rng = RandomNumberGenerator.new()


class Room:
		var rect: Rect2
		var center: Vector2
		var customRoomIndex
		#use -1 for no custom room
		func _init(x: int, y: int, w: int, h: int, roomInd):
			rect = Rect2(x, y, w, h)
			center = rect.position + rect.size / 2.
			customRoomIndex = roomInd
			

var rooms = []
@export var roomCount = 5
var start = randi_range(0,1)

#X is min, Y is max
@export var posRange = Vector2i(0, 100)
@export var minRoomOffset = 10
@export var hallWidth = 3

var roomTiles:Array

#Put index of rooms you want and then the amount of them (-1 for any amount)
#if any amount then add 3rd parameter for weight (1 out of x chance)
var customRoomAtlas:Array = [[0,1],[1,-1,4]]





func generate_roomsPoints(map:TileMapLayer, roomNumber:int, minSize:int, maxSize:int, debugLines:bool, customRooms:bool):
	#generate room positions and sizes
	var customRoomArray:Array
	
	
	if customRooms:
		for room in customRoomAtlas:
			if room[1] != -1:
				for i in room[1]:
					if customRoomArray.size() < roomNumber:
						customRoomArray.append(room[0])
		while roomNumber > customRoomArray.size():
			for room in customRoomAtlas:
				if room[1] == -1 and rng.randi_range(1,room[2]) == 1:
					customRoomArray.append(room[0])
				else:
					customRoomArray.append(null)
				
	print(customRoomArray)
	for i in customRoomArray:
		if i == null:
			var overflowCount = 0
			while overflowCount <= 100:
				var size = Vector2(rng.randi_range(minSize, maxSize), rng.randi_range(minSize, maxSize))
				var pos = Vector2(rng.randi_range(posRange.x, posRange.y), rng.randi_range(posRange.x, posRange.y)) # Adjust range as needed
				var new_room = Room.new(pos.x, pos.y, size.x, size.y, null)
				if !room_overlaps(new_room):
					rooms.append(new_room)
					break
				else:
					overflowCount+=1
		else:
			
			var roomData = map.tile_set.get_pattern(i)
			var overflowCount = 0
			while overflowCount <= 100:
				var size = roomData.get_size()
				var pos = Vector2(rng.randi_range(posRange.x, posRange.y), rng.randi_range(posRange.x, posRange.y))
				var new_room = Room.new(pos.x, pos.y, size.x, size.y, i)
				if !room_overlaps(new_room):
					rooms.append(new_room)
					break
				else:
					overflowCount+=1
				
	#check for overlaps
		
	# ============= ༼ つ ◕_◕ ༽つ ============= #
	var edges = delauney()
	var mst = generateMst(edges)
	
	roomGen(map)
	
	
	
	var filledHalls = halls(mst, 2, map, null)
	halls(mst, 0, map, filledHalls)
	
	Globals._mapGen.emit()
	debugLineGen(mst, debugLines)
	

func roomGen(map):
	# Wall Gen
	for room in rooms:
		
		if room.customRoomIndex == null and room.rect.size != Vector2():
			#walls
			var pos = room.rect.position
			var size = Vector2(room.rect.size.x +1, room.rect.size.y +1)
			for h in range(size.x):
				var target1 = Vector2i(pos.x+h,pos.y)
				var target2 = Vector2i(pos.x+h,pos.y+size.y)
				
				if map.get_cell_source_id(target1) == -1:
					map.set_cell(target1, 0, Vector2i(5,0))
				if map.get_cell_source_id(target2) == -1:
					map.set_cell(target2, 0, Vector2i(5,0))
				
				for k in range(size.y):
					var target3 = Vector2i(pos.x,pos.y+k)
					var target4 = Vector2i(pos.x+size.x,pos.y+k)
					
					if map.get_cell_source_id(target3) == -1:
							map.set_cell(target3, 0, Vector2i(5,0))
					if map.get_cell_source_id(target4) == -1:
							map.set_cell(target4, 0, Vector2i(5,0))
			if map.get_cell_source_id(Vector2i(pos.x+size.x,pos.y+size.y)) == -1:
				map.set_cell(Vector2i(pos.x+size.x,pos.y+size.y), 0, Vector2i(5,0))

	# Floor Gen
			pos = Vector2(room.rect.position.x +1, room.rect.position.y+1)
			size = room.rect.size
			for h in range(size.x):
				for k in range(size.y):
					map.set_cell(Vector2i(pos.x+h,pos.y+k), 0, Vector2i(0,0))
					if k != 0:
						roomTiles.append(Vector2i(pos.x+h,pos.y+k))
		else:
			map.set_pattern(room.rect.position,map.tile_set.get_pattern(room.customRoomIndex))
			for x in room.rect.size.x:
				for y in room.rect.size.y:
					var check = Vector2(room.rect.position.x+x,room.rect.position.y+y)
					if map.get_cell_tile_data(check) and map.get_cell_tile_data(check).get_custom_data("Wall") == false:
						roomTiles.append(check)
		
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

func halls(mst, mod, map, filled):
	#rng to vary hallway direction
	
	var holder = hallWidth
	holder += mod
	
	var marked = []
	
	for line in mst:
		var yDir = 1
		var yStart
		#If first point below the second, change range iterate direction
		#This part makes the hallway have a full corner
		var firstY =line[0].y
		var lastY = line[1].y
		if firstY > lastY:
			firstY += (holder-1)/2
			yDir = -1
		else:
			firstY -= (holder-1)/2
		if start==0:
			yStart = line[0].x
		else:
			yStart = line[1].x
		
		#Dig vertical halls

		for vert in range(firstY, lastY, yDir):
			for i in range(holder):
				var target = Vector2i(yStart-(holder-1)/2+i, vert)
				if map.get_cell_source_id(target) == -1 or checkIfOuterWall(map, target) or (filled and filled.has(target)):
					marked.append(target)
				
				
			

		#same for horizontals
		var xDir = 1
		#This part makes the hallway have a full corner
		var firstX =line[0].x
		var lastX = line[1].x
		if firstX > lastX:
			firstX += (holder-1)/2
			xDir = -1
		else:
			firstX -= (holder-1)/2
			
		var xStart
		if start==0:
			xStart = line[1].y
		else:
			xStart = line[0].y
		
		for hor in range(firstX, lastX, xDir):
			for i in range(holder):
				var target = Vector2i(hor, xStart-(holder-1)/2+i)
				
				if map.get_cell_source_id(target) == -1 or checkIfOuterWall(map, target) or (filled and filled.has(target)):
					marked.append(target)
				
		### Place Custom Room ###
		#for e in customRoomAtlas:
#			if map.get_cell_atlas_coords(Vector2i(int(e[0].x) - customRoomCenter.x, int(e[0].y) - customRoomCenter.y)) != Vector2i(0, 0):
#				map.set_cell(Vector2i(int(e[0].x) - customRoomCenter.x, int(e[0].y) - customRoomCenter.y), 0, Vector2i(int(e[1].x), int(e[1].y)))
	for target in marked:
		if mod == 0:
			map.set_cell(target, 0, Vector2i(0,0))
		else:
			map.set_cell(target, 0, Vector2i(5,0))
	
	return marked

func checkIfOuterWall(map, target):
	var outer = false
	var inner = false
	
	var count = 0
	var around = map.get_surrounding_cells(target)
	for i in range(3,16,4):
		#check outer
		if map.get_cell_source_id(map.get_neighbor_cell(target,i)) == -1 or map.get_cell_source_id(around[count]) == -1:
			outer = true
		#check corners for inner
		elif map.get_cell_tile_data(map.get_neighbor_cell(target,i)) and map.get_cell_tile_data(map.get_neighbor_cell(target,i)).get_custom_data("Wall") == false:
			inner = true
		#check sides for inner
		elif map.get_cell_tile_data(around[count]) and map.get_cell_tile_data(around[count]).get_custom_data("Wall") == false:
			inner = true
		
		count += 1
		
	if inner and outer:
		return true
	else:
		return false
#	
	

# Cool line generator
func debugLineGen(mst, enableRoomDebugLines):
	if enableRoomDebugLines:
		for line in mst:
			var trace = Line2D.new()
			add_child(trace)
			trace.add_point(line[0]*64)
			trace.add_point(line[1]*64)
