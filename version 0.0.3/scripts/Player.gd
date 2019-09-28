extends Node2D


var speed = 500
var move = true


func _ready():
	pass


func _process(delta):
	if move:
		moving(delta)


func moving(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		if position.x <= 3250:
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


func _on_Buttle_GUI_Player_stop():
	move = false
	$AnimatedSprite.stop()


func _on_Enemy_Player_can_move():
	move = true
	$AnimatedSprite.play()


func _on_GUI_Player_die():
	hide()

