extends Control



func _ready():
	$SattingsMenu.hide()
	pass

func _on_SattingsButton_pressed():
	if $SattingsMenu.is_visible_in_tree():
		$SattingsMenu.hide()
	else:
		$SattingsMenu.show()

func _on_Exit_pressed():
	get_tree().quit()
