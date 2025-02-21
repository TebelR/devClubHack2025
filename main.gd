extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(OS.get_name().contains("Android") or OS.get_name().contains("iOS")):
		set_portrait_mode()#in the case if a phone running this app
	else:
		set_landscape_mode()#In the case of a PC running this app
	proceedToScene("MenuScene")



func set_portrait_mode():
	var screen_size = Vector2(DisplayServer.screen_get_size())
	if screen_size.x > screen_size.y:
		DisplayServer.screen_set_orientation(DisplayServer.SCREEN_PORTRAIT)



func set_landscape_mode():
	var screen_size = Vector2(DisplayServer.screen_get_size())
	if screen_size.x < screen_size.y:
		DisplayServer.screen_set_orientation(DisplayServer.SCREEN_LANDSCAPE)



func proceedToScene(scene):
	load("res://" + scene + "tscn")




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
