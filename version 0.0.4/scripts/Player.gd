extends Node2D

signal Refresh_stamina
signal Refresh_health
signal GUI_button_block
signal GUI_button_free
signal GUI_button_deffence_block
signal GUI_button_deffence_free
signal GUI_button_attack_block
signal GUI_button_attack_free
signal Attack_enemy_go_Main
signal Attack_enemy_go_Enemy
signal Deffence_enemy_go_Main
signal Deffence_enemy_go_Enemy

onready var Global = get_node("/root/Global")
var speed = 500
var move = true
var block = false


func _ready():
	$AnimatedSprite.play("Walk")


func _process(delta):
	if move:
		moving(delta)



func moving(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		if position.x <= 4000:
			velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		if position.x >= 100:
			velocity.x -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play("Walk")
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
	$AnimatedSprite.play("Walk")


func _on_Buttle_GUI_Player_attack():
	emit_signal("GUI_button_attack_free")
	if Global.player_stamina >= Global.player_stamina_sub:
		emit_signal("GUI_button_deffence_free")
		emit_signal("GUI_button_block")
		Global.player_stamina -= Global.player_stamina_sub
		$AnimatedSprite.play("Attack")
		$AnimatedSprite.connect("animation_finished", self, "stop_animation")
		emit_signal("Refresh_stamina")
		emit_signal("Attack_enemy_go_Main")
	else:
		emit_signal("GUI_button_attack_block")

func Attack_Enemy_from_Main():
	emit_signal("Attack_enemy_go_Enemy")


func stop_animation():
	if $AnimatedSprite.is_playing():
		$AnimatedSprite.stop()
		emit_signal("GUI_button_free")
		
		
func Enemy_attack_Player():
	if block:
		Global.player_hp -=  int(rand_range(Global.enemy_dmg_min, Global.enemy_dmg_max)) / 2
		block = false
	else:
		Global.player_hp -= int(rand_range(Global.enemy_dmg_min, Global.enemy_dmg_max))
	emit_signal("Refresh_health")

func _on_Buttle_GUI_Player_defence():
	if Global.player_stamina < 100:
		block = true 
		emit_signal("GUI_button_block")
		Global.player_stamina += 50
		if Global.player_stamina >= 100:
			Global.player_stamina = 100
		$AnimatedSprite.play("Deffence")
		$AnimatedSprite.connect("animation_finished", self, "stop_animation")
		emit_signal("Refresh_stamina")
		emit_signal("Deffence_enemy_go_Main")
	elif Global.player_stamina >= 100:
		emit_signal("GUI_button_deffence_block") 