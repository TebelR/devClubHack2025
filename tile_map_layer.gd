extends Node2D

var tile_section = []

var section_start = Vector2(-14, 6)
var section_end = Vector2(8, 14)

var info_bubble: Label
var hide_timer: Timer

func _ready():
	set_process_input(true)
	set_process(true)
	info_bubble = Label.new()
	info_bubble.text = "Info about tile"
	info_bubble.anchor_right = 1
	info_bubble.anchor_bottom = 1
	info_bubble.visible = false
	add_child(info_bubble)

	hide_timer = Timer.new()
	hide_timer.one_shot = true
	hide_timer.wait_time = 3
	hide_timer.connect("timeout", Callable(self, "_on_hide_bubble_timeout"))
	add_child(hide_timer)

	tile_section = get_tile_section(section_start, section_end)
	
func get_tile_section(start: Vector2, end: Vector2) -> Array:
	var section = []

	for x in range(start.x, end.x + 1):
		for y in range(start.y, end.y + 1):
			section.append(Vector2(x, y))

	return section
	
func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		var mouse_pos = get_global_mouse_position()
		print("Mouse Position: ", mouse_pos)
		var tile_pos = screen_to_tile(mouse_pos)
		print("Tile Position: ", tile_pos)
		
		if tile_pos.x >= section_start.x and tile_pos.x <= section_end.x and tile_pos.y >= section_start.y and tile_pos.y <= section_end.y:
			show_info_bubble(tile_pos)
			
func screen_to_tile(mouse_pos: Vector2) -> Vector2:
	var tile_size = Vector2(32, 32)
	return (mouse_pos / tile_size).floor()
	
func show_info_bubble(tile_pos: Vector2):
	var bubble_pos = tile_pos * Vector2(32, 32) + Vector2(16, -32)

	info_bubble.position = bubble_pos
	info_bubble.text = "Tile Position: (%d, %d)\nWorking Properly\nHackathon YAY" % [tile_pos.x, tile_pos.y]
	info_bubble.visible = true

	hide_timer.start()
	
func _on_hide_bubble_timeout():
	info_bubble.visible = false
