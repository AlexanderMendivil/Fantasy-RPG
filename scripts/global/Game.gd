extends Node


signal player_health_changed(health: int)
var items: Dictionary = {
	"long sword": preload("res://scenes/player/GUI/inventory/long_sword.tres"),
	"iron sword": preload("res://scenes/player/GUI/inventory/iron_sword.tres"),
	"small potion": preload("res://scenes/player/GUI/inventory/small_potion.tres"),
	}
var gold: int = 100	
var on_player_health: int = 10 
var player_health_max: int = 10
var player_stamina_max: float = 100
var player_stamina__pasive_increase: float = 20
var right_hand_equipped: ItemData
var body_equipped: ItemData
var player_damage: int = 0
var player_defense: int = 0



func heal_player(heal: int) -> bool:			
	player_health_changed.emit(heal)
	return true

		