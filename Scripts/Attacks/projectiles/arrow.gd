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

func hitWall():
	print("hit wall")
	set_physics_process(false)
	var ogScale = sprite.scale
	for i in 10:
		sprite.scale = ogScale * 1/i


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("hit smth")
	if body.has_meta("Enemy"):
		print("Arrow hit enemy")
	else:
		print("hit not an enemy")
		hitWall()
