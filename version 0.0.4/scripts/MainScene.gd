extends Node



onready var Player = $Player
onready var Enemy = [ $Enemy, $Enemy2 ]
onready var Exit = $Exit_level
var n = 0
var enemy_alive = true



func _on_Player_Attack_enemy_go_Main():
	check_enemies()
	Player.emit_signal("Attack_enemy_go_Enemy")
		
func check_enemies():
	Enemy[n].connect("Attack_Player", Player, "Enemy_attack_Player")
	Player.connect("Attack_enemy_go_Enemy", Enemy[n], "Attack_enemy_go_Enemy")

func _on_Player_Deffence_enemy_go_Main():
	Player.connect("Deffence_enemy_go_Enemy", Enemy[n], "Deffence_enemy_go_Enemy")
	Player.emit_signal("Deffence_enemy_go_Enemy")

func _on_Enemy_Enemy_died():
	n += 1
	Global.enemy_hp = 100
	Global.enemy_stamina = 100


func _on_Player_body_entered(Exit):
	if n >= 2:
		get_tree().change_scene("res://scenes/locations/Camp.tscn")
