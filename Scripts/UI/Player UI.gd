extends Control

@onready var healthBar = $"Health Bar"
@onready var manaBar = $"Mana Bar"

func _process(_delta: float) -> void:
	healthBar.value = Globals.playerHealth
	manaBar.value = Globals.playerMana
