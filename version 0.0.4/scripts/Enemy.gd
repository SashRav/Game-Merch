extends StaticBody2D


signal Attack_Player
signal Player_can_move
signal Hide_battle_gui
signal Enemy_died

onready var Global = get_node("/root/Global")
onready var HpLable = $Health
onready var StLalle = $Stamina

func _ready():
	HpLable.text = str(Global.enemy_hp)
	StLalle.text = str(Global.enemy_stamina)
	$AnimatedSprite.play("default")

func stop_animation():
	if $AnimatedSprite.is_playing():
		$AnimatedSprite.stop()

func Enemy_damage():
	if Global.enemy_stamina < Global.enemy_stamina_sub:
		Global.enemy_hp -=  int(rand_range(Global.player_dmg_min, Global.player_dmg_max)) / 2
	else:
		Global.enemy_hp -= int(rand_range(Global.player_dmg_min, Global.player_dmg_max))

func Enemy_Attack():
	if Global.enemy_stamina >= Global.enemy_stamina_sub:
		Global.enemy_stamina -= Global.enemy_stamina_sub
		StLalle.text = str(Global.enemy_stamina)
		$AnimatedSprite.play("Attack")
		$AnimatedSprite.connect("animation_finished", self, "stop_animation")
		emit_signal("Attack_Player")
	elif Global.enemy_stamina < Global.enemy_stamina_sub:
		Global.enemy_stamina = 0
		Global.enemy_stamina += 55
		StLalle.text = str(Global.enemy_stamina)
		$AnimatedSprite.play("Deffence")
		$AnimatedSprite.connect("animation_finished", self, "stop_animation")

	
func Attack_enemy_go_Enemy():
	Enemy_damage()
	if Global.enemy_hp <= 0:
		Global.enemys_killed += 1
		emit_signal("Hide_battle_gui")
		emit_signal("Player_can_move")
		emit_signal("Enemy_died")
		queue_free()
	HpLable.text = str(Global.enemy_hp)
	Enemy_Attack()
		
func Deffence_enemy_go_Enemy():
	Enemy_Attack()
		