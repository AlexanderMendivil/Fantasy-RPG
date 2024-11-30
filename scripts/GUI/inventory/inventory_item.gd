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


func init(d: ItemData) -> void:
	data = d


func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(make_drag_preview(at_position))
	return self

func make_drag_preview(at_position: Vector2) -> Control:
	var texture_node: TextureRect = TextureRect.new()
	texture_node.texture = data.item_texture		
	texture_node.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	texture_node.stretch_mode = TextureRect.StretchMode.STRETCH_KEEP_ASPECT_CENTERED 
	texture_node.custom_minimum_size = self.size
	texture_node.modulate.a = 0.5
	texture_node.position = Vector2(-at_position)
	var control_node: Control = Control.new()
	control_node.add_child(texture_node)

	return control_node
