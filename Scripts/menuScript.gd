extends Node2D



func _ready():
	$VBoxContainer/botonStart.grab_focus()
	


func _on_boton_start_pressed():
	pass
	# Poner la escena del juego
	#get_tree().change_scene_to_file("res://Scenes/mundo.tscn")
func _on_boton_quit_pressed():
	get_tree().quit()
	
