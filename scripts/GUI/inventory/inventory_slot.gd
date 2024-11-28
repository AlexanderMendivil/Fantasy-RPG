class_name InventorySlot
extends PanelContainer
 
@export var type: ItemData.ItemType

func init(t: ItemData.ItemType, cms: Vector2) -> void:
	type = t
	custom_minimum_size = cms

func _can_drop_item_data() -> bool:
	return true	

func _drop_data(at_position: Vector2, data: Variant) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass	