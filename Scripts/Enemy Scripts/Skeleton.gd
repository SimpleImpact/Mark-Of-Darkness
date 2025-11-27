extends CharacterBody2D


@export var maxSpeed = 500

#time to reach max speed 
@export var accel = 0.5
#Time to go back from max to zero
@export var decel = 0.25
#How smooth and round to make turns
@export var turnWeight = 5

@export var maxHealth = 100
var health = maxHealth

@export var stopDist = 3
@export var sight = 5

@onready var sprite = $Sprite

var curSpeed = 0
var lastVelo = Vector2(0,0)
var lastSeen:Vector2

var n = 0

@onready var nav: NavigationAgent2D = $NavigationAgent
@onready var ray = $RayCast2D
#Health Math: round(health ÷ (maxHealth ÷ 30)) = frame number 

func _ready():
	set_physics_process(false)
	await get_tree().physics_frame
	await get_tree().physics_frame
	await get_tree().physics_frame
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
	
func _physics_process(delta):
	var player = Globals.player
	var playerDist = Globals.distance(self.position, player.position)
	if not player:
		return
	var input_dir = get_input()
	#Increase current speed when given input
	if lastVelo and input_dir and curSpeed<maxSpeed:
		curSpeed += maxSpeed*delta/accel
	#If no input decrease speed
	elif curSpeed>0:
		curSpeed -= maxSpeed*delta/decel
	
	#Reset last velocity if not moving or input
	if curSpeed == 0 and not input_dir:
		lastVelo = Vector2(0,0)
	
	#Ensures speed doesnt go above max or below zero
	if curSpeed<0:
		curSpeed = 0
	elif curSpeed>maxSpeed:
		curSpeed = maxSpeed
	
	#Apply input and speed to velocity and move
	velocity = lastVelo*curSpeed
	move_and_slide()

func _on_hitbox_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.has_meta("Type"):
		if area.get_meta("Type") == "Attack":
			health -= area.get_meta("Damage")
			print("Hit")
	if health <= 0:
		sprite.play("Death")
		set_physics_process(false)
