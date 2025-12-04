extends CharacterBody2D


@export var speed = 250

#time to reach max speed 
@export var accel = 0.5
#Time to go back from max to zero
@export var decel = 0.25
#How smooth and round to make turns
@export var turnWeight = 5

@export var maxHealth = 100
var health = maxHealth

@export var stopDist = 20
@export var sight = 500

@onready var sprite = $Sprite

var curSpeed = 0
var lastVelo = Vector2(0,0)
var lastSeen:Vector2

#Movement Curve
var movePattern = preload("res://Enemies/Movement Functions/skeleton.tres")

var playerReady:bool = Globals.pReady

# Will be this far from the player with a margin of error of abt 5(subject to change)
var hoverDist = 20

@onready var nav: NavigationAgent2D = $NavigationAgent
@onready var ray = $RayCast2D

func _ready():
	while not Globals.pReady:
		set_physics_process(false)
	set_physics_process(true)

func _process(_delta: float) -> void:
	$Healthbar.frame = round(float(health) / (float(maxHealth) / 30))

func get_input():
	var player = Globals.player
	var pPos = Globals.playerPos
	if not player:
		return
	ray.target_position = pPos - global_position
	if ray.is_colliding() and ray.get_collider() == player and player.global_position.distance_to(global_position) <= sight*64:
		lastSeen = pPos
		nav.target_position = lastSeen
	else:
		sprite.play("Idle")
	var direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	var stopped = false
	#check to see if at last seen
	if global_position < lastSeen-Vector2(stopDist,stopDist) and global_position > lastSeen+Vector2(stopDist,stopDist):
		stopped = true

	if lastSeen and not stopped:
		#Smooth the direction change out by avg last direction with input and use turnWeight
		lastVelo = ((lastVelo*turnWeight)+direction)/(turnWeight+1)
		return direction
	
func _physics_process(_delta):
	var pReady = Globals.pReady
	var pPos = Globals.playerPos
	
	### HOW TO USE MOVEMENT ###
	# In res://Enemies/Movement Functions, there are curvs to adjust 
	# the speed at differant distances (This is to make hovering at a general area easier)
	
	if pReady:
		var player = Globals.player
		var dist = Vector2((position.x - pPos.x) / sight, (position.y - pPos.y) / sight)
		if Globals.distance(Globals.playerPos, position) < sight:
			if dist.x < 0:
				velocity.x = Globals.Round(movePattern.sample_baked(-dist.x), 3) * speed
			else:
				velocity.x = -Globals.Round(movePattern.sample_baked(dist.x), 3) * speed
			if dist.y < 0:
				velocity.y = Globals.Round(movePattern.sample_baked(-dist.y), 3) * speed
			else:
				velocity.y = -Globals.Round(movePattern.sample_baked(dist.y), 3) * speed
			if velocity.x < 10 and velocity.x > -10: velocity.x = 0.0
			if velocity.y < 10 and velocity.y > -10: velocity.y = 0.0
		move_and_slide()

func _on_hitbox_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.has_meta("Type"):
		if area.get_meta("Type") == "Attack":
			health -= area.get_meta("Damage")
	if health <= 0:
		sprite.play("Death")
		set_physics_process(false)
