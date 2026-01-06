extends Node2D

var cooldown := true

var sprite: AnimatedSprite2D = null
@onready var arrowScene = load("res://Attacks/Projectiles/Arrow.tscn")

func _ready() -> void:
	# Try common resolutions for the sprite being null:
	sprite = get_node_or_null("BowSprite")
	if not sprite:
		# search recursively for a node named BowSprite
		sprite = find_child("BowSprite", true, false)
	if not sprite:
		# fallback: find first AnimatedSprite2D child anywhere under this node
		for c in get_tree().get_nodes_in_group("_temp_search_group"): # ...no-op placeholder...
			pass
		for c in get_children():
			if c is AnimatedSprite2D:
				sprite = c
				break
	if not sprite:
		push_warning("Bow.gd: could not find 'BowSprite' or any AnimatedSprite2D child. Check node name/structure.")
	else:
		# optional: print for debugging
		print("Bow sprite found: ", sprite.get_path())

func _process(_delta: float) -> void:
	if Input.is_action_pressed("Attack") and cooldown:
		var arrow = arrowScene.instantiate()
		arrow.rotation_degrees = rotation_degrees
		Globals.projectileContainer.add_child(arrow)
		look_at(get_global_mouse_position())
		# ...existing code...
		if sprite:
			sprite.play("Shoot")
		else:
			push_warning("Bow.gd: sprite is null when trying to play 'Shoot'")
		cooldown = false
		start_timer()

func start_timer() -> void:
	# SceneTree.create_timer returns a SceneTreeTimer; await its timeout instead of trying to connect
	await get_tree().create_timer(0.25).timeout
	cooldown = true
