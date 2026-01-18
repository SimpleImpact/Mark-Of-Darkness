extends Node

### ===================================> IMPORTANT <======================================= ###
### ==========> This script if for storing global variables and functions ONLY <=========== ###
### ===============> Do not attatch this script anywhere, call it globaly <================ ###
### ======================================================================================= ###

signal _mapGen
signal _playerSpawned

var openTiles:Array #Dictionary to hold all spawnable tiles, custom rooms will not be here. The data is stored like this "roomNumber:Vector2i(69, 420)"
var playerPos:Vector2
var player:CharacterBody2D
var debug = false
var CamPos:Vector2
var CamZoom = Vector2(0.75, 0.75)
var playerHealth = 100
var maxPlayerHealth = 100
var playerMana = 100
var maxPlayerMana = 100
var projectileContainer:Node

var spawnReady = true

var pReady = false


#Collision layer reference: 
#1:character 2: char projectile 3: enemy 4: enemy projectile/dmg of some sort
#5: walls


func distance(pos1:Vector2, pos2:Vector2):
	return(sqrt((pos2.x - pos1.x) **2 + (pos2.y - pos1.y) **2))

### These are both needed idk why ###
func _ready() -> void:
	pass
func _process(_delta: float) -> void:
	pass

func Round(value, deci):
	return(round(value * (10 ** deci)) / (10 ** deci))
