extends Node

@export var inventory_size: int = 24
@onready var grid = get_node("GridContainer")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(inventory_size - 1):
		var slot = InventorySlot.new()
		slot.init(ItemData.ItemType.MAIN, Vector2(32, 32))
		grid.add_child(slot)
	
	add_item("long sword")
	add_item("small potion")

func add_item(item_name: String) -> void:
	var item = InventoryItem.new()
	item.init(Game.items[item_name])	
	
	if item.data.stackable:
		for i in range(inventory_size - 1):
			var grid_child = grid.get_child(i) 
			if grid_child.get_child_count() > 0:
				if item.data ==  grid_child.get_child(0).data:
					grid_child.get_child(0).data.count += 1
					grid_child.get_child(0).get_child(0).text = grid_child.get_child(0).data.count
					break
			else:
				grid_child.add_child(item)
				break

	else:
		for i in range(inventory_size - 1):
			if grid.get_child(i).get_child_count() == 0:
				grid.get_child(i).add_child(item)
				break			


