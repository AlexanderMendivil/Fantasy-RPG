extends Node
var StateController

func _ready() -> void:
	StateController = get_parent().get_parent()
	if StateController.is_awake:
		await StateController.get_node("AnimationTree").animation_finished
	
	StateController.is_attacking = true
	StateController.get_node("AnimationTree").get("parameters/playback").travel("2H_Melee_Attack_Slice")	
	StateController.look_at(StateController.player.global_transform.origin)
	
func _physics_process(_delta: float) -> void:
	if StateController:
		StateController.velocity.x = 0
		StateController.velocity.z = 0
