extends AnimatedSprite2D

var cooldown = true

func _process(_delta: float) -> void:
	if Input.is_action_pressed("Attack") and cooldown:
		look_at(get_global_mouse_position())
		rotation_degrees += 90
		play("shoot")
		cooldown = false
		start_timer()

func start_timer():
	var timer = get_tree().create_timer(0.25)
	timer.timeout.connect(timeout_function)

func timeout_function():
	cooldown = true
