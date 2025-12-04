extends Node2D

@onready var curve = preload("res://Test.tres")

func _ready() -> void:
	print(Globals.Round(curve.sample_baked(0.3), 3))
