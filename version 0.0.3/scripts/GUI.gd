extends MarginContainer

signal Player_die
signal Attack_blocked
signal Can_attack
signal Player_deffence
onready var menu_bc = $HBoxContainer/Sattings_button/Satting_background
onready var hp_bar = $HBoxContainer/VBoxContainer/HP_HBoxContainer/HP_TextureProgress
onready var hp_counter = $HBoxContainer/VBoxContainer/HP_HBoxContainer/HP_bar_info/HP_Label
onready var st_bar = $HBoxContainer/VBoxContainer/ST_HBoxContainer/ST_TextureProgress
onready var st_counter = $HBoxContainer/VBoxContainer/ST_HBoxContainer/ST_bar_info/ST_Label
onready var health = Global.player_hp
onready var stamina = Global.player_stamina
onready var kills = $HBoxContainer/VBoxContainer/HP_HBoxContainer/Kills/Kills

func _ready():
	menu_bc.hide()
	health_output(health)
	stamina_output(stamina)
	kills.text = str(Global.enemys_killed)
	
	
func stamina_output(stamina):
	st_bar.value = stamina
	st_counter.text = str(stamina)
	
	
func health_output(health):
	hp_bar.value = health
	hp_counter.text = str(health)


func _on_Sattings_button_pressed():
	if menu_bc.is_visible_in_tree():
		menu_bc.hide()
	else:
		menu_bc.show()


func _on_Satting_exit_pressed():
	get_tree().quit()


func _on_Enemy_Attack_player():
	stamina -= Global.player_stamina_sub
	if stamina < 0:
		stamina = 0
	stamina_output(stamina)
	if stamina >= Global.player_stamina_sub:
		health -= int(rand_range(Global.enemy_dmg_min, Global.enemy_dmg_max))
		health_output(health)
		if health <= 0:
			hp_bar.hide()
			hp_counter.hide()
			emit_signal("Player_die")
	else:
		emit_signal("Attack_blocked")


func _on_Buttle_GUI_Player_defence():
	stamina += 50
	if stamina > 100:
		stamina = 100
	stamina_output(stamina)
	emit_signal("Can_attack")
	emit_signal("Player_deffence")


func _on_Enemy_Attack_player_with_dmg():
	health -= int(rand_range(Global.enemy_dmg_min, Global.enemy_dmg_max))
	health_output(health)


func _on_Enemy_Enemy_died():
	kills.text = str(Global.enemys_killed)


func _on_Kills_button_pressed():
	if Global.enemys_killed > 0:
		health = 100
		stamina = 100
		Global.enemys_killed -= 1
	kills.text = str(Global.enemys_killed)
	health_output(health)
	stamina_output(stamina)
	
