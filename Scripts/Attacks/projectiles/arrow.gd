extends CharacterBody2D

var yFactor = sin(rotation)
var xFactor = cos(rotation)

@export var baseSpeed = 1500
var tweenSpriteScale : Tween
var tweenSpritePos : Tween
@onready var sprite = $Sprite2D

func _ready() -> void:
	yFactor = sin(rotation)
	xFactor = cos(rotation)
	velocity = Vector2(xFactor*ProjectileGlobals.speedFactor, yFactor*ProjectileGlobals.speedFactor) *baseSpeed

func _physics_process(_delta: float) -> void:
	move_and_slide()

func hitWall():
	set_physics_process(false)
	tweenSpriteScale = create_tween()
	tweenSpritePos = create_tween()
	tweenSpriteScale.tween_property(sprite, "scale", Vector2(0, 0), 2)
	tweenSpritePos.tween_property(sprite, "position", Vector2(100, 0), 2)
	await tweenSpritePos.finished
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_class() == "TileMapLayer":
		hitWall()
