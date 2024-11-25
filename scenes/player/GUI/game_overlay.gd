extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	
func show_game_over() -> void:
	show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)		


func _on_retry_pressed() -> void:	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().reload_current_scene()
