extends Node3D


@onready var h_node: Node3D = %h 
@onready var v_node: SpringArm3D = %v

@export var cam_v_max: int = 75
@export var cam_v_min: int = -55

var h_sensitivity: float = 0.01
var v_sensitivity: float = 0.01
var h_acceleration: float = 10.0
var v_acceleration: float = 10.0
var cam_root_h: float = 0
var cam_root_v: float = 0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func  _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cam_root_h += -event.relative.x * h_sensitivity
		cam_root_v += event.relative.y * v_sensitivity

func _physics_process(delta: float) -> void:
	cam_root_v = clamp(cam_root_v, deg_to_rad(cam_v_min), deg_to_rad(cam_v_max))
	h_node.rotation.y = lerpf(h_node.rotation.y, cam_root_h, delta * h_acceleration)
	v_node.rotation.x = lerpf(v_node.rotation.x, cam_root_v, delta * v_acceleration)