extends Node
var StateController

func _ready() -> void:
	StateController = get_parent().get_parent()
	if StateController.is_awake:
		await StateController.get_node("AnimationTree").animation_finished

	StateController.get_node("AnimationTree").get("parameters/playback").travel("Sit_Floor_Idle")
	
func _physics_process(delta: float) -> void:
	if StateController:
		StateController.velocity.x = 0
		StateController.velocity.z = 0