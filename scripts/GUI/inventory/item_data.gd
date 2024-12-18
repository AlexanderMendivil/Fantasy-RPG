class_name ItemData
extends Resource

@export var item_name: String = ""


enum ItemType {
 	WEAPON,
	HEAD,
	BODY,
	LEGS,
	FEET,	
	MISC,
	MAIN,
}
@export var item_type: ItemType
@export var item_damage: int
@export var item_defense: int
@export var item_health: int
@export var stackable: bool
@export var count: int = 0
@export_multiline var description: String
@export var item_texture: Texture2D