extends CharacterBody2D

var yFactor = sin(rotation)
var xFactor = cos(rotation)

@export var baseSpeed = 1500

@onready var sprite = $Sprite2D
	
func _physics_process(_delta: float) -> void:
	yFactor = sin(rotation)
	xFactor = cos(rotation)
	velocity = Vector2(xFactor*ProjectileGlobals.speedFactor, yFactor*ProjectileGlobals.speedFactor) *baseSpeed
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has_meta("Enemy"):
		if !area.get_meta("Enemy"):
			print("Arrow hit enemy")
			hitWall()

func hitWall():
	set_physics_process(false)
	for i in 10:
		sprite.scale -= 1
