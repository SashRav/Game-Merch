extends MarginContainer

signal Player_stop
signal Player_attack
signal Player_defence
var can_attack = true
var enemy_alive = false 

func _ready():
	hide()

func _on_Player_body_entered(Enemy):
	show()
	emit_signal("Player_stop")


func _on_Button_Attack_pressed():
	if can_attack:
		emit_signal("Player_attack")
		
	
func _on_Button_Defence_pressed():
	emit_signal("Player_defence")


func _on_Enemy_Player_can_move():
	hide()


func _on_GUI_Attack_blocked():
	can_attack = false


func _on_GUI_Can_attack():
	can_attack = true


func _on_Enemy_Hide_battle_gui():
	hide()


func _on_Enemy_Enemy_died():
	pass
