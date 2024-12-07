extends Control

func _process(_delta: float) -> void:
	get_node("stats_label").text = "Player health: %s\n Player attack: %s\n Player defense: %s\n Player level: %s\n Player XP: %s\n"%[Game.player_health_max, Game.player_damage, Game.player_defense, Game.player_level,  Game.xp_to_next_level]
