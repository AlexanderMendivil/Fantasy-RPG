extends CharacterBody3D


@onready var state_controller = $StateMachine

@export var player: CharacterBody3D

const speed: float = 1.0
var direction: Vector3
var is_awake: bool = false
var is_attacking: bool = false
var health: int = 4
var damage: int = 2
var is_dying: bool = false
var just_hit: bool = false

func _ready() -> void:
	state_controller.change_state("Idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if player:
		direction = (player.global_transform.origin - global_transform.origin).normalized()

	
	move_and_slide()

func _on_chase_player_section_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		print(body.name)
		state_controller.change_state("Run")


func _on_attack_player_section_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		print(body.name)
		state_controller.change_state("Attack")


func _on_chase_player_section_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		state_controller.change_state("Idle")


func _on_attack_player_section_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		state_controller.change_state("Run")
