extends StaticBody2D


signal Attack_player
signal Attack_player_with_dmg
signal Player_can_move
signal Hide_battle_gui
signal Enemy_died


onready var health = Global.enemy_hp
onready var stamina = Global.enemy_stamina

func _ready():
	$Health.text = str(health)
	$Stamina.text = str(stamina)

func player_attack():
	health -= int(rand_range(Global.player_dmg_min, Global.player_dmg_max))
	$Health.text = str(health)
	if health <= 0:
		Global.enemys_killed += 1
		emit_signal("Hide_battle_gui")
		emit_signal("Player_can_move")
		emit_signal("Enemy_died")
		health = 100
		stamina = 100
		queue_free()
	if stamina >= Global.enemy_stamina_sub:
		emit_signal("Attack_player")
		stamina -= Global.enemy_stamina_sub
		if stamina < 0:
			stamina = 0
		$Stamina.text = str(stamina)
	else:
		stamina += 50
		$Stamina.text = str(stamina)


func player_deffence():
	$Health.text = str(health)
	if stamina >= Global.enemy_stamina_sub:
		emit_signal("Attack_player_with_dmg")
		stamina -= Global.enemy_stamina_sub
		if stamina < 0:
			stamina = 0
		$Stamina.text = str(stamina)
	else:
		stamina += 50
		$Stamina.text = str(stamina)

func _on_Buttle_GUI_Player_attack():
	player_attack()

func _on_GUI_Player_deffence():
	player_deffence()
		
