extends TileMap

@export var mapWidth = 50
@export var mapHeight = 50

@export var minRoomSize = 5
@export var maxRoomSize = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DungeonGen.generate(self, mapWidth, mapHeight, minRoomSize, maxRoomSize)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func gen(_e):
	DungeonGen.generate(self, mapWidth, mapHeight, minRoomSize, maxRoomSize)
