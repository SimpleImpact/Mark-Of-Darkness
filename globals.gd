extends Node

# ==================================> IMPORTANT <=======================================
# ==========> This script if for storing global variables and functions ONLY<===========
# ===============> Do not attatch this script anywhere, call it globaly <===============
# ======================================================================================

var openTiles:Dictionary #Dictionary to hold all spawnable tiles, custom rooms will not be here. The data is stored like this "roomNumber:Vector2i(69, 420)"
var mapGenerated:bool = false
var playerPos:Vector2
var player
var debug = false
var CamPos:Vector2
var CamZoom = Vector2(0.75, 0.75)
var playerHealth = 100
var maxPlayerHealth = 100
var playerMana = 100
var maxPlayerMana = 100

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
