extends Node2D

var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(OS.get_name().contains("Android") or OS.get_name().contains("iOS")):
		set_portrait_mode()#in the case if a phone running this app
	else:
		set_landscape_mode()#In the case of a PC running this app
	proceedToScene("menu_scene")




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
