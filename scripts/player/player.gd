extends CharacterBody3D


@export var gravity: float = 9.8
@export var jump_force: int = 9
@export var walk_speed: int = 3
@export var run_speed: int = 10

var direction: Vector3 
var horizontal_velocity: Vector3 
var aim_turn: float
var movement: float
var vertical_velocity: Vector3 
var movement_speed: int 
var angular_acceleration: int 
var acceleration: int 
var just_hit: bool

@onready var camrot_h = %h

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		aim_turn += -event.relative.x * 0.015	

	if event.is_action_pressed('AIM'):
		direction = camrot_h.global_transform.basis.z
		
func _physics_process(delta: float) -> void:
	pass



class AnimationState:
	static var IDLE: String = 'idle'
	static var WALK: String = 'walk'
	static var JUMP: String = 'jump'
	static var RUN: String = 'run'
	static var ATTACK1: String = 'attack1'
	static var DEATH: String = 'death'

	static var IS_ATTACKING: bool = false
	static var IS_WALKING: bool = false
	static var IS_JUMPING: bool = false
	static var IS_DYING: bool = false
