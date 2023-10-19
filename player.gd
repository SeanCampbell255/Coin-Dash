extends Area2D

@export var speed = 350
var velocity = Vector2.ZERO
var screensize = Vector2(480, 720)

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
	
	var xdirection = velocity.sign().x
	var ydirection = velocity.sign().y
#	if $AnimatedSprite2D.flip_h:
#		if velocity.y > 0:
#			$AnimatedSprite2D.rotation = (-PI / 2) + (-PI / 4) * xdirection
#		else: if velocity.y < 0:
#			$AnimatedSprite2D.rotation = (PI / 2) + (PI / 4) * xdirection
#		else:
#			$AnimatedSprite2D.rotation = 0
#	else:
#		if velocity.y > 0:
#			$AnimatedSprite2D.rotation = (PI / 2) + (-PI / 4) * xdirection
#		else: if velocity.y < 0:
#			$AnimatedSprite2D.rotation = (-PI / 2) + (PI / 4) * xdirection
#		else:
#			$AnimatedSprite2D.rotation = 0
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
