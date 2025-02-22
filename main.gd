extends Node2D

var current_scene = null
var cur_lon = 0
var cur_lat = 0
var phone_flag = null
@onready var android_loc_plugin = get_node("AndroidGeolocationPlugin")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(OS.get_name().contains("Android") or OS.get_name().contains("iOS")):
		set_portrait_mode()#in the case if a phone running this app
		android_loc_plugin._request_location_permission()
		await(android_loc_plugin.android_location_permission_updated)
		android_loc_plugin.android_location_updated.connect(self._on_location_update)
		android_loc_plugin._start_geolocation_listener(5000, 0.0)#milisec timeout, minDist
		phone_flag = true
	else:
		set_landscape_mode()#In the case of a PC running this app
		phone_flag = false
		print("Running on PC, location is the default main floor of eng")
		cur_lat = 49.80865
		cur_lon = -97.13403
	
	proceedToScene("menu_scene")


func _on_location_update(location_dictionary: Dictionary) -> void:
	var cur_lat: float = location_dictionary["latitude"]
	var cur_lon: float = location_dictionary["longitude"]




func set_portrait_mode():
	var screen_size = Vector2(DisplayServer.screen_get_size())
	if screen_size.x > screen_size.y:
		DisplayServer.screen_set_orientation(DisplayServer.SCREEN_PORTRAIT)



func set_landscape_mode():
	var screen_size = Vector2(DisplayServer.screen_get_size())
	if screen_size.x < screen_size.y:
		DisplayServer.screen_set_orientation(DisplayServer.SCREEN_LANDSCAPE)



#this is the most simple loading/unloading of scenes.
#If a scene has a player inside of it, additional resource management is needed to remove the player and stuff
func proceedToScene(scene_name: String):
	if current_scene:
		current_scene.queue_free()
		
	var new_scene = load("res://" + scene_name + ".tscn").instantiate()
	add_child(new_scene)
	current_scene = new_scene




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func get_location():
	var output = Vector2(cur_lat, cur_lon)
	return output
