extends CharacterBody2D

@onready var sprite := $Sprite2D  # Get the sprite reference
@onready var anim_player := $AnimationPlayer  # Get AnimationPlayer
@onready var camera = $Camera2D

var pos_tile: Vector2
var pos_viewport: Vector2 
var tilemap = null

const SPEED = 30#300.0
var last_direction := "down"  # Store the last movement direction


func activate_camera():
	if(camera):
		camera.enabled = true
	
func disable_camera():
	if(camera):
		camera.enabled = false


func _physics_process(_delta: float) -> void:
	tilemap = get_parent().get_node("TileMapLayer")
	if(tilemap):
		var viewport = get_viewport_rect().size * 0.5
		pos_tile = tilemap.local_to_map(global_position)
		pos_viewport = global_position - viewport
		
		var gyro = Input.get_gyroscope()
		var direction := Vector2(
			gyro.x,
			gyro.y
			)
		
		if(gyro.x == 0 and gyro.y == 0 and gyro.z == 0):
			var mouse_pos = get_viewport().get_mouse_position()
			mouse_pos.x -= get_viewport_rect().size.x/2
			mouse_pos.y -= get_viewport_rect().size.y/2
			if((mouse_pos.x < get_viewport_rect().size.x*0.3 and mouse_pos.x>get_viewport_rect().size.x*-0.3) and (mouse_pos.y < get_viewport_rect().size.y*0.3 and mouse_pos.y > get_viewport_rect().size.y*-0.3)):
				direction = Vector2(0,0)
			else:
				direction = (mouse_pos).normalized()
			
		
		#print(pos_tile)
		if Input.is_action_just_pressed("ui_accept"):
			print("Space key pressed")
	
		velocity = direction * SPEED
	
		# Play correct animation based on direction
		if direction != Vector2.ZERO:
			if direction.x > 0:
				anim_player.play("move_right")
				last_direction = "right"
			elif direction.x < 0:
				anim_player.play("move_left")
				last_direction = "left"
			elif direction.y > 0:
				anim_player.play("move_down")
				last_direction = "down"
			elif direction.y < 0:
				anim_player.play("move_up")
				last_direction = "up"
		else:
			# Play idle animation based on last movement direction
			if(anim_player):
				anim_player.play("idle_" + last_direction)

	move_and_slide()
	
	
	
	
#cleanup method - this functions like a destructor
func _exit_tree():
	disable_camera()
