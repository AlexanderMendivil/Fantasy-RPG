extends Node3D

var cam_root_h: int = 0
var cam_root_v: int = 0

@export var cam_v_max: int = 75
@export var cam_v_min: int = -55

var h_sensitivity: float = 0.01
var v_sensitivity: float = 0.01
var h_acceleration: float = 10.0
var v_acceleration: float = 10.0


func  _input(event: InputEvent) -> void:
	print("something", event)