class_name InventoryItem
extends TextureRect

@export var data: ItemData

func _ready() -> void:
	if data:
		expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		stretch_mode = TextureRect.StretchMode.STRETCH_KEEP_ASPECT_CENTERED 
		texture = data.item_texture
		tooltip_text = "Name: %s  \n%s\nStats \n Damage: %s Defense: %s Health: %s"%[data.item_name, data.description, data.item_damage, data.item_defense, data.item_health]

		if data.stackable:
			var label = Label.new()
			label.text = str(data.count)
			label.position = Vector2(24, 16)
			add_child(label)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
