extends CharacterBody2D

@onready var _animated_sprite = $Player
@export var rotation_speed = 1.5
var rotation_direction = 0
var dash = true

var speed = 400
var target
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Animations Initalized")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Input.is_action_pressed("Up") and Input.is_action_pressed("Down"):
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
	get_input()
	if Input.is_action_pressed("Mouse") and dash:
		if position.distance_to(target) > 50:
			print(self.position.distance_to(target))
			velocity = position.direction_to(target) * self.position.distance_to(target) * Engine.get_frames_per_second()/4
			print(Engine.get_frames_per_second())
			start_timer()
			dash = false
	move_and_slide()

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed * 1
	target = Vector2(0, 0)
	target = get_global_mouse_position()

func start_timer():
	var timer = get_tree().create_timer(1.0)
	timer.timeout.connect(timeout_function)

func timeout_function():
	dash = true
