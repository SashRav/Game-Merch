extends MarginContainer


onready var Global = get_node("/root/Global")
onready var menu_bc = $HBoxContainer/Sattings_button/Satting_background
onready var hp_bar = $HBoxContainer/VBoxContainer/HP_HBoxContainer/HP_TextureProgress
onready var hp_counter = $HBoxContainer/VBoxContainer/HP_HBoxContainer/HP_bar_info/HP_Label
onready var st_bar = $HBoxContainer/VBoxContainer/ST_HBoxContainer/ST_TextureProgress
onready var st_counter = $HBoxContainer/VBoxContainer/ST_HBoxContainer/ST_bar_info/ST_Label
onready var kills = $HBoxContainer/VBoxContainer/HP_HBoxContainer/Kills/Kills

func _ready():
	menu_bc.hide()
	health_output()
	stamina_output()
	
func health_output():
	hp_bar.value = Global.player_hp
	hp_counter.text = str(Global.player_hp)


func stamina_output():
	st_bar.value = Global.player_stamina
	st_counter.text = str(Global.player_stamina)


func _on_Sattings_button_pressed():
	if menu_bc.is_visible_in_tree():
		menu_bc.hide()
	else:
		menu_bc.show()


func _on_Satting_exit_pressed():
	get_tree().quit()

#####################################################
func _on_Player_Refresh_stamina():
	stamina_output()


func _on_Player_Refresh_health():
	health_output()


func _on_Enemy_Enemy_died():
	kills.text =  str(Global.enemys_killed)

func _on_Kills_button_pressed():
	if Global.enemys_killed > 0:
		Global.player_hp = 100
		Global.player_stamina = 100
		Global.enemys_killed -= 1
	kills.text = str(Global.enemys_killed)
	health_output()
	stamina_output()