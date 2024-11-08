extends Node
var StateController

func _ready() -> void:	
	StateController = get_parent().get_parent()
	if StateController.is_attacking:
		await StateController.get_node("AnimationTree").animation_finished

	StateController.get_node("AnimationTree").get("parameters/playback").travel("Cheer")
	
func _physics_process(_delta: float) -> void:    
	if StateController:
		StateController.velocity.x = 0
		StateController.velocity.z = 0