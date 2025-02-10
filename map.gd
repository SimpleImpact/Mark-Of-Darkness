extends TileMap

@export var mapWidth = 50
@export var mapHeight = 50

var height = 0
var width = 0

@export var minRoomSize = 5
@export var maxRoomSize = 15

var openTiles = []

var process = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DungeonGen.generate(self, mapWidth, mapHeight, minRoomSize, maxRoomSize)
	start_timer()
	print(get_parent())
	
func _process(delta: float) -> void:
	pass
	
func start_timer():
	var timer = get_tree().create_timer(2.0)
	timer.timeout.connect(timeout_function)

func timeout_function():
	openTiles = []
	for i in mapWidth * mapHeight:
		if width >= 50:
			height += 2
			width = 0
		if (get_cell_source_id(0, Vector2i(width, height)) == -1):
			openTiles.append(Vector2i(width, height))
		width += 1
	print(openTiles.size())
