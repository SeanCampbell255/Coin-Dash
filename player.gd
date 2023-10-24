extends Area2D
## Signals
signal pickup
signal hurt

## Variables
@export var speed = 350
var velocity = Vector2.ZERO
var screensize = Vector2(480, 720)

func start():
	## Init
	set_process(true)
	position = screensize / 2
	$AnimatedSprite2D.animation = "idle"

func _process(delta):
	## Inputs -> Movement
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += velocity * speed * delta
	position.x = clamp(position.x, 15, screensize.x - 15)
	position.y = clamp(position.y, 25, screensize.y - 25)
	
	## Movement -> Animation
	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
		
	## Movement -> Rotation
	var xdirection = velocity.sign().x
	if xdirection < 0:
		xdirection *= 3
	else:
		xdirection *= -1
	
	if velocity.y < 0:
		$AnimatedSprite2D.rotation = (-PI / 2) + (-PI / 4) * xdirection
	else: if velocity.y > 0:
		$AnimatedSprite2D.rotation = (PI / 2) + (PI / 4) * xdirection
	else:
		$AnimatedSprite2D.rotation = 0
	## For when sprite is flipped and moving only along y
	if $AnimatedSprite2D.flip_h && velocity.y && !velocity.x: $AnimatedSprite2D.rotation += PI

## Custom Functions

func die():
	$AnimatedSprite2D.animation = "hurt"
	set_process(false)


func _on_area_entered(area):
	if area.is_in_group("coins"):
		area.pickup()
		pickup.emit("coin")
	if area.is_in_group("powerups"):
		area.pickup()
		pickup.emit("powerup")
	if area.is_in_group("obstacles"):
		hurt.emit()
		die()
