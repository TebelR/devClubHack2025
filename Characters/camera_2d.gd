extends Camera2D


@onready var player = get_parent()  # Assumes Camera2D is inside the player node

func _process(delta):
	global_position = player.global_position  # Keep camera centered on player
	
