extends Control

func _process(delta: float) -> void:
	get_node("stats_label").text = "Player health: %s\n Player attack: %$s\n Player defense: %s\n Player level: %s\n Player XP: %s\n"%[]
