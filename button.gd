extends Button

func _pressed() -> void:
	var main = get_node("/root/Main")
	main.proceedToScene("eng_main_scene")
