extends Node2D

var origin_lon = 49.80861
var origin_lat = -97.13403

var SCALE = 1000

func worldToTile(location:Vector2):
	var tile_x = (location.x - origin_lon) * SCALE  # Calculate based on longitude
	var tile_y = (location.y - origin_lat) * SCALE  # Calculate based on latitude
	var output = Vector2(tile_x, tile_y)
	
	print(location)
	print("VS")
	print(output)
	return output
	
	
func _ready() -> void:
	#need to get player coordinates before spawning
	if (get_tree()):
		var root = get_tree().root.get_node("Main")
		spawnPlayer(root.get_location())#spawn at 0,0 for now
	
	
func update_player_loc(real_pos:Vector2):
	#var player = find_child("*Player*")
	var children = get_children()
	for child in children:
		if(child.name == "Player"):
			var tile_pos = worldToTile(real_pos)
			child.update_pos(tile_pos)
	
	
	
	
func spawnPlayer(location_real:Vector2):
	var location = worldToTile(location_real)
	var player= preload("res://Characters/player.tscn").instantiate()
	add_child(player)
	player.position = location
	player.activate_camera()
	
