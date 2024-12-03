extends CharacterBody2D


@onready var nav: NavigationAgent2D = $NavigationAgent
@onready var ray = $RayCast2D
@onready var sprite = $Sprite
@onready var player = get_parent().get_parent().get_parent().get_child(0)
var rng = RandomNumberGenerator.new()
const speed = 200
const accel = 10
var maxHealth = 100
var health = 100
#Health Math: round(health ÷ (maxHealth ÷ 30)) = frame number 

func _ready():
	set_physics_process(false)
	await get_tree().physics_frame
	set_physics_process(true)

func _process(_delta: float) -> void:
	$Healthbar.frame = round(float(health) / (float(maxHealth) / 30))

func _physics_process(delta: float) -> void:
	var direction = Vector3()
	ray.target_position = player.position - global_position
	
	move_and_slide()
	
	if ray.is_colliding():
		if ray.get_collider() == player:
			nav.target_position = player.position

	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	velocity = velocity.lerp(direction * speed, accel * delta)
	
	if velocity.x < 1:
		sprite.play("Run Left")
	else:
		sprite.play("Run Right")

func _on_hitbox_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.get_meta("Type") == "Attack":
		health -= area.get_meta("Damage")
	if health <= 0:
		sprite.play("Death")
		set_physics_process(false)
