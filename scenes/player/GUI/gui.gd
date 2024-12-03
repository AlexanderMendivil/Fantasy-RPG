extends CanvasLayer

var AnimationState = preload("res://utils/animation_state.gd").AnimationState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("container").visible = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ESC") and !AnimationState.IS_DYING:		 
		get_tree().paused = !get_tree().paused
		get_node("container").visible = get_tree().paused
		
		match get_tree().paused:
			true:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			false:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_player_on_player_health(health: float) -> void:	 
	if health <= 0:
		get_node("HP_bar").value = 0
	else:
		get_node("HP_bar").value = health
		
		



func _on_profile_button_pressed() -> void:
	get_node("container/VBoxContainer/inventory_button").disabled = true
	get_node("container/VBoxContainer/profile_button").disabled = false
	get_node("container/inventory").show()
	get_node("container/profile").hide()


func _on_inventory_button_pressed() -> void:
	get_node("container/VBoxContainer/inventory_button").disabled = false
	get_node("container/VBoxContainer/profile_button").disabled = true
	get_node("container/inventory").hide()
	get_node("container/profile").show()


func _on_player_on_player_stamina(stamina:float) -> void:
	if stamina <= 0:
		get_node("stamina_bar").value = 0
	else:
		get_node("stamina_bar").value = stamina
