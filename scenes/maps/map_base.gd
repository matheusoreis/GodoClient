class_name MapBase extends Node2D

@export var chars_location: Node2D


func spawn_char(id: int, char_name: String, char_gender: String, pos_x: int, pos_y: int, local_player: bool) -> void:
	var char_res = preload('res://scenes/entities/player/base_char.tscn') as PackedScene
	var char_instantiate: BaseCharacter = char_res.instantiate()
	char_instantiate.name = str(id)
	char_instantiate.player_id = id
	char_instantiate.player_name = char_name
	char_instantiate.gender = char_gender
	char_instantiate.position = Vector2(pos_x, pos_y)
	char_instantiate.is_local_player = local_player
	
	chars_location.add_child(char_instantiate)
