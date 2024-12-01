extends Node


signal player_health_changed(health: int)
var items: Dictionary = {
	"long sword": preload("res://scenes/player/GUI/inventory/long_sword.tres"),
	"iron sword": preload("res://scenes/player/GUI/inventory/iron_sword.tres"),
	"small potion": preload("res://scenes/player/GUI/inventory/small_potion.tres"),
	}
var gold: int = 100	
var on_player_health: int = 5 
var player_health_max: int = 5
var right_hand_equipped: ItemData
var body_equipped: ItemData
var player_damage: int = 0
var player_defense: int = 0



func heal_player(heal: int) -> void:
	if (on_player_health + heal) >= player_health_max:
		pass
	else:
		on_player_health += heal
		player_health_changed.emit(on_player_health)

		