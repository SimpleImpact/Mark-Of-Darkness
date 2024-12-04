extends CharacterBody2D

@onready var _animated_sprite = $"Player Sprite"
var dash = true
var v = Vector2(0, 0)
var friction = 0.25
var dashCof = 8

var speed = 1
var target
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Animations Initalized")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	playerInfo.playerPos = _animated_sprite.position
	
	if Input.is_action_pressed("Down") and Input.is_action_pressed("Left") and Input.is_action_pressed("Up") and Input.is_action_pressed("Right"):
		_animated_sprite.play("Rouge Idle")
	
	elif Input.is_action_pressed("Up") and Input.is_action_pressed("Down"):
		if Input.is_action_pressed("Right"):
			_animated_sprite.play("Rouge Run Right")
		elif Input.is_action_pressed("Left"):
			_animated_sprite.play("Rouge Run Left")
		else:
			_animated_sprite.play("Rouge Idle")
	
	elif Input.is_action_pressed("Left") and Input.is_action_pressed("Right"):
		if Input.is_action_pressed("Down"):
			_animated_sprite.play("Rouge Run Left")
			
		elif Input.is_action_pressed("Up"):
			_animated_sprite.play("Rouge Run Right")
		
		else:
			_animated_sprite.play("Rouge Idle")
		
	elif Input.is_action_pressed("Right") and Input.is_action_pressed("Left"):
		_animated_sprite.play("Rouge Idle")
		
	elif Input.is_action_pressed("Up") and Input.is_action_pressed("Left"):
		_animated_sprite.play("Rouge Run Left")
		
	elif Input.is_action_pressed("Right") or Input.is_action_pressed("Up"):
		_animated_sprite.play("Rouge Run Right")
		
	elif Input.is_action_pressed("Left") or Input.is_action_pressed("Down"):
		_animated_sprite.play("Rouge Run Left")
		
	else:
		_animated_sprite.play("Rouge Idle")
	pass
	
func _physics_process(_delta: float) -> void:
	
	if v.x < 400 * speed:
		if Input.is_action_pressed("Right"):
			v.x = 400 * speed
	if v.x > -400 * speed:
		if Input.is_action_pressed("Left"):
			v.x = -400 * speed
	if v.y > -400 * speed:
		if Input.is_action_pressed("Up"):
			v.y = -400 * speed
	if v.y < 400 * speed:
		if Input.is_action_pressed("Down"):
			v.y = 400 * speed
			
	if Input.is_action_pressed("Down") and Input.is_action_pressed("Up"):
			v.y = 0
	if Input.is_action_pressed("Right") and Input.is_action_pressed("Left"):
			v.x = 0
				
	v = v / (friction + 1)
	if Input.is_action_pressed("Mouse2") and dash:
		v.x *= dashCof
		v.y *= dashCof
		start_timer()
		dash = false
		
	velocity = v
	move_and_slide()

func get_input():
	pass

func start_timer():
	var timer = get_tree().create_timer(1.0)
	timer.timeout.connect(timeout_function)

func timeout_function():
	dash = true
