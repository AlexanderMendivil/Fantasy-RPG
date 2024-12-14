extends CharacterBody3D
const PlayerAnimationState = preload("res://utils/animation_state.gd").AnimationState

@onready var state_controller = $StateMachine

@export var player: CharacterBody3D


const speed: float = 200.0
var direction: Vector3
var is_awake: bool = false
var is_attacking: bool = false
var health: int = 4:
	set(value):
		var tween = create_tween()		
		tween.tween_property(self, "global_position", global_position - (direction/1.5), 0.2)							
		await tween.finished
		tween.kill()
		if(value <= 0):
			state_controller.change_state("Death")
			Game.enemies_killed +=1		
			return
		health = value

var damage: int = 2
var is_dying: bool = false
var just_hit: bool = false
@onready var chase_player_section: Area3D = $chase_player_section

func _ready() -> void:	
	state_controller.change_state("Idle")

func _physics_process(delta: float) -> void:	
	if not is_on_floor():
		velocity += get_gravity() * delta

	_player_position()	
	move_and_slide()


func _player_position() -> void:
	if player:		
		direction = (player.global_transform.origin - global_transform.origin).normalized()

func _on_chase_player_section_body_entered(body: Node3D) -> void:
	if body.name == "Player" and !is_dying:				
		state_controller.change_state("Run")


func _on_attack_player_section_body_entered(body: Node3D) -> void:
	if body.name == "Player" and !is_dying:		
		state_controller.change_state("Attack")


func _on_chase_player_section_body_exited(body: Node3D) -> void:
	if body.name == "Player" and !is_dying:		
		state_controller.change_state("Idle")


func _on_attack_player_section_body_exited(body: Node3D) -> void:
	if body.name == "Player" and !is_dying:		
		state_controller.change_state("Run")

func _on_animation_tree_animation_finished(anim_name:StringName) -> void:	
	if "Skeletons_Awaken_Standing"  in anim_name:
		is_awake = false
	elif ("2H_Melee_Attack_Slice" in anim_name) and PlayerAnimationState.IS_DYING:				
		state_controller.change_state("Cheer")
	elif ("2H_Melee_Attack_Slice" in anim_name) and (player in chase_player_section.get_overlapping_bodies() and !is_dying):				
		state_controller.change_state("Attack")		
	elif "Death" in anim_name:
		death()


func  mid_animation_trigger() -> void:	
		just_hit = true		

func _on_area_3d_body_entered(body:Node3D) -> void:				
	if body.name == "Player" and !is_dying and is_attacking and just_hit:				
		just_hit = false
		body.health -= damage

func death() -> void:		
	_reset_skeleton()
	queue_free()

func _reset_skeleton() -> void:
	health = 4
	is_dying = false
	state_controller.change_state("Idle")