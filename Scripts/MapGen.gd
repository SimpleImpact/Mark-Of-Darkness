extends TileMap

var rng = RandomNumberGenerator.new()

class Room:
	var rect: Rect2
	var center: Vector2

	func _init(x: int, y: int, w: int, h: int):
		rect = Rect2(x, y, w, h)
		center = rect.position + rect.size / 2

var rooms = []
@export var roomCount = 5

#X is min, Y is max
@export var roomSizeRange = Vector2i(8,20)
@export var posRange = Vector2i(10,100)
@export var minRoomOffset = 10

@export var hallWidth = 3
#unused for now:
var maxRoomOffset = 50

var mapBorder = 50


func generate_rooms():
	#generate room positions and sizes
	while rooms.size() < roomCount:
		var size = Vector2(rng.randi_range(roomSizeRange.x, roomSizeRange.y), rng.randi_range(roomSizeRange.x, roomSizeRange.y))
		var position = Vector2(rng.randi_range(posRange.x, posRange.y), rng.randi_range(posRange.x, posRange.y)) # Adjust range as needed
		var new_room = Room.new(position.x, position.y, size.x, size.y)
	#check for overlaps
		if !room_overlaps(new_room):
			rooms.append(new_room)
	
	#create big block ༼ つ ◕_◕ ༽つ
	for h in range(posRange.x-mapBorder,posRange.y+mapBorder):
		for k in range(posRange.x-mapBorder,posRange.y+mapBorder):
			set_cell(0,Vector2i(h,k),0,Vector2i(0,0),0)
	
	#Draw out rooms
	for room in rooms:
		var pos = room.rect.position
		var size = room.rect.size
		for h in range(size.x):
			for k in range(size.y):
				erase_cell(0,Vector2i(pos.x+h,pos.y+k))
			
	
#func for overlap check
func room_overlaps(new_room: Room) -> bool:
	for room in rooms:
		var expanded = room.rect.grow(minRoomOffset/2)
		if expanded.intersects(new_room.rect.grow(minRoomOffset/2)):
			return true
	return false


func delauney():
	#get room centers, then triangulate
	var centers = PackedVector2Array()
	for room in rooms:
		centers.append(room.center)
	#Returns triangles by the index of the point in the table
	var triangulation = Geometry2D.triangulate_delaunay(centers)
	
	#Get all edges
	var edges = []
	for i in range(len(triangulation)/3):
		edges.append([triangulation[i*3],triangulation[(i*3)+1]])
		edges.append([triangulation[i*3+1],triangulation[(i*3)+2]])
		edges.append([triangulation[i*3+2],triangulation[(i*3)]])
	return edges


#Get the minimum spanning tree
func findMst(v,disjointSet):
	while disjointSet[v] != v:
		v = disjointSet[v]
	return v

func union(a,b,disjointSet):
	disjointSet[findMst(a,disjointSet)] = findMst(b,disjointSet)

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

#use mst to dig halls
func halls(mst):
	#rng to vary hallway direction
	var start = randi_range(0,1)
	
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
		
		#use rng to change hall bend
		if start==0:
			yStart = line[0].x
		else:
			yStart = line[1].x
		
		#Dig vertical halls
		for vert in range(firstY, lastY, yDir):
			for i in range(hallWidth):
				erase_cell(0,Vector2i(yStart-(hallWidth-1)/2+i, vert))
		
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
				erase_cell(0,Vector2i(hor, xStart-(hallWidth-1)/2+i))

func _ready() -> void:
	generate_rooms()
	var edges = delauney()
	var mst = generateMst(edges)
	
	for line in mst:
		var trace = Line2D.new()
		add_child(trace)
		trace.add_point(line[0]*16)
		trace.add_point(line[1]*16)
	
	halls(mst)
