extends Node
var StateController

func _ready() -> void:
	StateController = get_parent().get_parent()

	