extends Control

@onready var label: Label = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = "Count: %s"%[Game.enemies_killed]
	Game.connect("enemy_killed_count", _on_enemies_count)

func _on_enemies_count() -> void:
	label.text = "Count: %s"%[Game.enemies_killed]