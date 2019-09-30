extends MarginContainer


signal Player_stop
signal Player_attack
signal Player_defence


onready var Global = get_node("/root/Global") 
var can_press = true
var deffence = false
var attack = true

func _ready():
	hide()
	 

func _on_Player_body_entered(Enemy):
	show()
	emit_signal("Player_stop")
	

func _on_Button_Attack_pressed():
	if can_press:
		emit_signal("Player_attack")
		
	
func _on_Button_Defence_pressed():
	if can_press:
		if deffence:
			emit_signal("Player_defence")


func _on_Enemy_Player_can_move():
	hide()


func _on_Enemy_Hide_battle_gui():
	hide()


func _on_Player_GUI_button_block():
	can_press = false


func _on_Player_GUI_button_free():
	can_press = true


func _on_Player_GUI_button_deffence_block():
	deffence = false


func _on_Player_GUI_button_deffence_free():
	deffence = true


func _on_Player_GUI_button_attack_block():
	attack = false


func _on_Player_GUI_button_attack_free():
	attack = true