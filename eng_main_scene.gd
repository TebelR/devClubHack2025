extends Node2D

var origin_lon = 49.80861
var origin_lat = -97.13403



func worldToTile(lat, lon):
	var tile_x = (lon - origin_lon)  # Calculate based on longitude
	var tile_y = (lat - origin_lat)  # Calculate based on latitude
	
	return Vector2(tile_x, tile_y)
	
	
func _ready() -> void:
	#need to get player coordinates before spawning
	if (get_tree()):
		var root = get_tree().root.get_node("Main")
		var location = root.get_location()
		spawnPlayer(location.x, location.y)#spawn at 0,0 for now
	

	
func spawnPlayer(x, y):
	var location = worldToTile(x,y)
	var player= preload("res://Characters/player.tscn").instantiate()
	add_child(player)
	player.position = location
	player.activate_camera()
	
