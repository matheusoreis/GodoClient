class_name MapBase extends Node2D

@export var chars_location: Node2D


func spawn_char(id: int, name: String, pos_x: int, pos_y: int) -> void:
	var char_res = preload('res://scenes/entities/player/base_char.tscn') as PackedScene
	var char_instantiate: BaseCharacter = char_res.instantiate()
	char_instantiate.name = str(id)
	char_instantiate.player_id = id
	char_instantiate.player_name = name
	char_instantiate.position = Vector2(pos_x, pos_y)
	char_instantiate.is_local_player = true
	
	chars_location.add_child(char_instantiate)
