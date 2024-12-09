extends TileMap

@export var mapWidth = 10
@export var mapHeight = 10

@export var minRoomSize = 5
@export var maxRoomSize = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DungeonGen.generate(self, mapWidth, mapHeight, minRoomSize, maxRoomSize)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	DungeonGen.generate(self, mapWidth, mapHeight, minRoomSize, maxRoomSize)
