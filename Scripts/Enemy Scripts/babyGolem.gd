extends CharacterBody2D

#Body parts

@onready var left = get_parent().find_child("LeftHand")
@onready var right = get_parent().find_child("RightHand")

@export var maxSpeed = 500

#time to reach max speed 
@export var accel = 0.5
#Time to go back from max to zero
@export var decel = 0.25
#How smooth and round to make turns
@export var turnWeight = 5

@export var maxHealth = 100
var health = maxHealth
@onready var zeroHP = $HealthbarBorder/HealthbarGreen.points[0].x
@onready var maxHP = $HealthbarBorder/HealthbarGreen.points[1].x

@export var stopDist = 3
@export var sight = 100

var curSpeed = 0
var lastVelo = Vector2(0,0)
var lastSeen = Vector2()

@onready var nav: NavigationAgent2D = $NavigationAgent
@onready var ray = $RayCast2D

var hoverDist = 250

func _ready() -> void:
	while not Globals.pReady:
		set_physics_process(false)
	set_physics_process(true)
	ray.add_exception(self)
	ray.add_exception(left)
	ray.add_exception(right)
	
	await get_tree().create_timer(randf_range(0,1)).timeout
	floaty()

func get_input():
	var player = Globals.player
	if not player:
		return
	ray.target_position = player.position - global_position
	if ray.is_colliding() and ray.get_collider() == player and player.global_position.distance_to(global_position) <= sight*64:
		lastSeen = player.position
		nav.target_position = lastSeen
	var direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	var stopped = false
	#check to see if at last seen
	if global_position < lastSeen-Vector2(stopDist,stopDist) and global_position > lastSeen+Vector2(stopDist,stopDist):
		stopped = true
	if Globals.distance(global_position, player.global_position) < hoverDist:
		direction = -direction
	if Globals.distance(global_position, player.global_position) > hoverDist - 10 and Globals.distance(global_position, player.global_position) < hoverDist + 10:
		stopped = true
	
	if lastSeen and !stopped:
		#Smooth the direction change out by avg last direction with input and use turnWeight
		lastVelo = ((lastVelo*turnWeight)+direction)/(turnWeight+1)
		return direction
		

@onready var body = $CollisionShape2D/Body
#Time for 1 anim loop
@export var floatLoop = 2.0
@onready var leftHand = self.get_parent().find_child("LeftHand").find_child("LeftHandSprite")
@onready var rightHand = self.get_parent().find_child("RightHand").find_child("RightHandSprite")
@onready var leftDif = global_position-leftHand.global_position
@onready var rightDif = global_position-rightHand.global_position
@export var handDelay = 0.5
func floaty():
	var tween = get_tree().create_tween().set_parallel(true)
	var sub = create_tween().set_loops()
	sub.tween_property(rightHand,"position",rightHand.position + (Vector2.DOWN*rightDif),floatLoop/2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	sub.tween_property(rightHand,"position",rightHand.position + (Vector2.UP*rightDif),floatLoop/2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	var sub2 = create_tween().set_loops()
	sub2.tween_property(leftHand,"position",leftHand.position + (Vector2.DOWN*leftDif),floatLoop/2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	sub2.tween_property(leftHand,"position",leftHand.position + (Vector2.UP*leftDif),floatLoop/2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_subtween(sub)
	tween.tween_subtween(sub2).set_delay(handDelay)
	tween.play()

func _physics_process(delta):
	var player = Globals.player
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
	
	
	#Hands stuff
	var prevPos = global_position
	if curSpeed != 0:
		await get_tree().create_timer(0.2).timeout
		self.get_parent().find_child("LeftHand").global_position = prevPos-leftDif
		await get_tree().create_timer(0.1).timeout
		self.get_parent().find_child("RightHand").global_position = prevPos-rightDif
	
func _process(_delta: float) -> void:

		
	var dist = Globals.distance(Vector2(zeroHP, 0), Vector2(maxHP, 0)) #Returns (64 - health/maxHealth) -32
	var targetHealth = Vector2(((dist * health/maxHealth) -32), 0)
	if targetHealth.x < zeroHP:
		$HealthbarBorder/HealthbarGreen.set_point_position(1, Vector2(zeroHP, 0))
	else:
		$HealthbarBorder/HealthbarGreen.set_point_position(1, targetHealth)

func _on_hitbox_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.has_meta("Type"):
		if area.get_meta("Type") == "Attack":
			health -= area.get_meta("Damage")
	if health <= 0:
		set_physics_process(false)
		await get_tree().create_timer(1).timeout
		get_parent().queue_free()
