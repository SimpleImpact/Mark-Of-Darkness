

slash = $Slash
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("Attack") and cooldown:
		slash.play("Slash")
		slash.rotation_degrees = rad_to_deg(get_angle_to(get_global_mouse_position())) + 90
		cooldown = false
		start_timer()
	pass
