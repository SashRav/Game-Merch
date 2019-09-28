extends Node

onready var enemy1 = $Enemy
onready var enemy2 = $Enemy2
onready var emeny1_alive = true
onready var emeny2_alive = true
onready var battle_gui = $Interface_Background/Buttle_GUI

func _ready():
	pass
	
	
func enemy_check():
	if emeny1_alive:
		battle_gui.connect("Player_attack", enemy1, "_on_Buttle_GUI_Player_attack")
		emeny1_alive = false
	elif emeny2_alive:
		battle_gui.connect("Player_attack", enemy2, "_on_Buttle_GUI_Player_attack")
		emeny2_alive = false


func _on_Buttle_GUI_Player_stop():
	enemy_check()
