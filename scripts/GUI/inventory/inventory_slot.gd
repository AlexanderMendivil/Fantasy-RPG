class_name InventorySlot
extends PanelContainer
 
@export var type: ItemData.ItemType

func init(t: ItemData.ItemType, cms: Vector2) -> void:
	type = t
	custom_minimum_size = cms

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is InventoryItem:
		if type == ItemData.ItemType.MAIN:
			if get_child_count() == 0:
				return true
			else:
				if type == data.get_parent().type:
					return true
				return get_child(0).item_data.type == ItemData.ItemType.MAIN
		else:
			return data.data.type == type
	
	return false
func _drop_data(at_position: Vector2, data: Variant) -> void:
	if get_child_count() > 0:
		var item = get_child(0)
		if item == data:
			return
		item.reparent(data.get_parent())		
	data.reparent(self)

func _physics_process(delta: float) -> void:
	pass	

func _gui_input(event: InputEvent) -> void:
	pass