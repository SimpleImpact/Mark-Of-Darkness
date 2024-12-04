extends AnimatedSprite2D

var cooldown = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("Attack") and cooldown:
		play("Slash")
		look_at(get_global_mouse_position())
		rotation_degrees += 90
		cooldown = false
		start_timer()
	pass

func start_timer():
		var timer = get_tree().create_timer(1.0)
		timer.timeout.connect(timeout_function)
			
func timeout_function():
		cooldown = true
