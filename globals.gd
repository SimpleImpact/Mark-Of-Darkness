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

func rect_distance(pos1:Vector2, pos2:Vector2):
	var xDist = abs(pos2.x - pos1.x)
	var yDist = abs(pos2.y - pos1.y)
	return(Vector2(xDist, yDist))

### These are both needed idk why ###
func _ready() -> void:
	pass
func _process(_delta: float) -> void:
	pass

func Round(value, deci):
	return(round(value * (10 ** deci)) / (10 ** deci))

func merge_all_nav_regions():
	var merged_poly := NavigationPolygon.new()

	for region in get_tree().get_nodes_in_group("nav_regions"):
		var poly: NavigationPolygon = region.navigation_polygon
		if poly == null:
			continue

		for i in range(poly.get_outline_count()):
			var outline = poly.get_outline(i)
			merged_poly.add_outline(outline)

	merged_poly.make_polygons_from_outlines()
	$MergedNavigationRegion.navigation_polygon = merged_poly
