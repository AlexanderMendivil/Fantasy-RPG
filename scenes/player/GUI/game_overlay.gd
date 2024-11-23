extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_game_over() -> void:
	show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)	
	get_tree().paused = true


func _on_retry_pressed() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().reload_current_scene()
