extends CharacterBody2D

@onready var sprite := $Sprite2D  # Get the sprite reference
@onready var anim_player := $AnimationPlayer  # Get AnimationPlayer
@onready var camera = $Camera2D


const SPEED = 300.0
var last_direction := "down"  # Store the last movement direction


func activate_camera():
	if(camera):
		camera.enabled = true
	
func disable_camera():
	if(camera):
		camera.enabled = false


func _physics_process(delta: float) -> void:
	var direction := Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

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
