extends CharacterBody2D


@onready var nav: NavigationAgent2D = $NavigationAgent
@onready var ray = $RayCast2D
@onready var sprite = $Sprite
var rng = RandomNumberGenerator.new()
const speed = 200
const accel = 10
var maxHealth = 100
var health = 100
#Health Math: round(health ÷ (maxHealth ÷ 30)) = frame number 

func _ready():
	set_physics_process(false)
	await get_tree().physics_frame
	await get_tree().physics_frame
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	var direction = Vector3()
	ray.target_position = playerInfo.playerPos
	
	nav.target_position = get_parent().get_parent().get_parent().get_child(0).position
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	velocity = velocity.lerp(direction * speed, accel * delta)
	
	move_and_slide()
	
	if ray.is_colliding():
		if ray.get_collider() == get_parent().get_parent().get_parent().get_child(0):
			print("e")
			
	if velocity.x < 1:
		sprite.play("Run Left")
	else:
		sprite.play("Run Right")

func _on_hitbox_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	print(area)
	pass # Replace with function body.
