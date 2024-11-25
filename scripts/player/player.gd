class_name Player

extends CharacterBody3D
const AnimationState = preload("res://utils/animation_state.gd").AnimationState
const InputMapAction = preload("res://utils/input_map_actions.gd").InputMapAction 

@onready var player_mesh: Node3D = %Knight

signal on_player_health(health: float)

@export var gravity: float = 9.8
@export var damage: float = 2
@export var health: float = 10:
	set(value):
		on_player_health.emit(value)
		if value <= 0:
			AnimationState.IS_DYING = true
			return
		health = value


@export var jump_force: int = 9
@export var walk_speed: int = 3
@export var run_speed: int = 10


var direction: Vector3
var horizontal_velocity: Vector3
var aim_turn: float
var movement: float
var vertical_velocity: Vector3
var movement_speed: int
var angular_acceleration: int = 10
var acceleration: int
var just_hit: bool

@onready var camrot_h: Node3D = %h
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

func _ready() -> void:
	on_player_health.emit(health)

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		aim_turn += -event.relative.x * 0.015

	if event.is_action_pressed(InputMapAction.AIM):
		direction = camrot_h.global_transform.basis.z
		
func _physics_process(delta: float) -> void:
	if !AnimationState.IS_DYING:
		attack()
		if is_on_floor():
			vertical_velocity = Vector3.DOWN * gravity/10
		else:
			vertical_velocity += Vector3.DOWN * gravity * 2 * delta
		
		if Input.is_action_pressed(InputMapAction.JUMP) and !AnimationState.IS_ATTACKING and is_on_floor():			
			AnimationState.IS_JUMPING = true
			vertical_velocity = Vector3.UP * jump_force			
			movement_speed = 0
			acceleration = 15			
		
		if AnimationState.ATTACK1 in playback.get_current_node():
			AnimationState.IS_ATTACKING = true			
		else:
			AnimationState.IS_ATTACKING = false

		var h_rot = camrot_h.global_transform.basis.get_euler().y
		if Input.is_action_pressed(InputMapAction.FORWARD) or Input.is_action_pressed(InputMapAction.BACKWARD) or Input.is_action_pressed(InputMapAction.LEFT) or Input.is_action_pressed(InputMapAction.RIGHT):
			AnimationState.IS_WALKING = true
			acceleration = 5
			direction = Vector3(Input.get_action_strength(InputMapAction.LEFT) - Input.get_action_strength(InputMapAction.RIGHT), 0, Input.get_action_strength(InputMapAction.FORWARD) - Input.get_action_strength(InputMapAction.BACKWARD))
			direction = direction.rotated(Vector3.UP, h_rot).normalized()
			if Input.is_action_pressed(InputMapAction.RUN):
				AnimationState.IS_RUNNING = true
				movement_speed = run_speed
			else:
				AnimationState.IS_WALKING = true		
				AnimationState.IS_RUNNING = false
				movement_speed = walk_speed
		else:
			AnimationState.IS_WALKING = false
			AnimationState.IS_RUNNING = false
			movement_speed = 0
			acceleration = 0
			direction = Vector3.ZERO
			horizontal_velocity = Vector3.ZERO
			vertical_velocity = Vector3.ZERO
			
		if Input.is_action_pressed(InputMapAction.AIM):			
			player_mesh.rotation.y = lerp_angle(player_mesh.rotation.y, camrot_h.rotation.y, delta*angular_acceleration)			
		else:
			player_mesh.rotation.y = lerp_angle(player_mesh.rotation.y, atan2(direction.x, direction.z) - rotation.y, delta*angular_acceleration)
		
		if AnimationState.IS_ATTACKING:
			horizontal_velocity = horizontal_velocity.lerp(direction.normalized()*0.1, acceleration*delta)
		else:
			horizontal_velocity = horizontal_velocity.lerp(direction.normalized()*movement_speed, acceleration*delta)
			
		velocity.z = horizontal_velocity.z + vertical_velocity.z
		velocity.x = horizontal_velocity.x + vertical_velocity.x
		velocity.y = vertical_velocity.y
		move_and_slide()
		animation_tree["parameters/conditions/isOnFloor"] = is_on_floor()
		animation_tree["parameters/conditions/isInAir"] = !is_on_floor()
		animation_tree["parameters/conditions/isWalking"] = AnimationState.IS_WALKING
		animation_tree["parameters/conditions/isNotWalking"] = !AnimationState.IS_WALKING
		animation_tree["parameters/conditions/isRunning"] = AnimationState.IS_RUNNING
		animation_tree["parameters/conditions/isNotRunning"] = !AnimationState.IS_RUNNING
		animation_tree["parameters/conditions/isDying"] = AnimationState.IS_DYING
	
	else:
	# player died
		_on_player_dispose()

func attack():	
	if (AnimationState.IDLE in playback.get_current_node()) or (AnimationState.WALK in playback.get_current_node()) or (AnimationState.RUN in playback.get_current_node()):		
		if Input.is_action_pressed(InputMapAction.ATTACK):
			if !AnimationState.IS_ATTACKING:
				playback.travel(AnimationState.ATTACK1)

				

func _on_player_dispose() -> void:	
	playback.travel(AnimationState.DEATH)
	
	await get_tree().create_timer(7.0).timeout
	_reset_player()
	get_node('../game_overlay').show_game_over()	


func _reset_player()-> void: 
	health = 10
	AnimationState.IS_DYING = false

func _on_collision_sword_area_body_entered(body:Node3D) -> void:
	if(body.is_in_group("monster") && AnimationState.IS_ATTACKING):		
		body.health -= damage
