extends Node2D

var speed = 500

func _ready():
	pass
	
func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		if position.x <= 3450:
			velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		if position.x >= 100:
			velocity.x -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	if velocity.x != 0:
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	$Camera2D.position = $AnimatedSprite.position
		
	position.x += velocity.x * delta
