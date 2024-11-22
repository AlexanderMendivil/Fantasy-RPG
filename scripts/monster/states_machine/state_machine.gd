extends Node

var states = {
	"Idle": preload("res://scripts/monster/states_machine/idle_state.gd"),
	"Attack": preload("res://scripts/monster/states_machine/attack_state.gd"),
	"Death": preload("res://scripts/monster/states_machine/death_state.gd"),
	"Run": preload("res://scripts/monster/states_machine/run_state.gd"),
	"Cheer": preload("res://scripts/monster/states_machine/cheer_state.gd"),
}


func change_state(state_name: String) -> void:
	if get_child_count() != 0:
		if !("Death" in get_child(0).name):
			get_child(0).queue_free()	

	if states.has(state_name):			
		var state_temp = states[state_name].new()
		state_temp.name = state_name
		add_child(state_temp)