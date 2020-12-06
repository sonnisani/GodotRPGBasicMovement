extends Node2D

func _on_HurtBox_area_entered(area):
	create_grass_effect()
	queue_free()

func create_grass_effect():
	var GrassEffect = load("res://Project1Game/GrassEffect.tscn")
	var grassEffect = GrassEffect.instance()
	var main = get_tree().current_scene
	main.add_child(grassEffect)
	grassEffect.global_position = global_position
	
