extends Node
var StateController

var is_running: bool

func _ready() -> void:
	StateController = get_parent().get_parent()
	if StateController.is_attacking:
		await StateController.get_node("AnimationTree").animation_finished
		StateController.is_attacking = false
	else:
		is_running = false
		StateController.get_node("AnimationTree").get("parameters/playback").travel("Skeletons_Awaken_Standing")
		StateController.is_awake = true
		await StateController.get_node("AnimationTree").animation_finished

	is_running = true
	StateController.is_awake = false

	if is_running:
		StateController.get_node("AnimationTree").get("parameters/playback").travel("Running_A")
	
func _physics_process(delta: float) -> void:
	if StateController and is_running:
		StateController.velocity.x += StateController.speed * delta
		StateController.velocity.z += StateController.speed * delta
		# StateController.look_at(StateController.player.global_transform.origin, StateController.direction, Vector3.UP)
		StateController.look_at(StateController.player.global_transform.origin)