class_name BaseMap extends Node2D


@export var character_spawn_location: Node2D


func get_character_by_id(id: int) -> BaseCharacter:
	for child in character_spawn_location.get_children():
		if child.name == str(id):
			return child as BaseCharacter
	return null


func spawn_char(id: int, char_name: String, char_gender: String, character_position: Vector2, direction: int, local_player: bool, default_sprite: String, current_sprite: String) -> void:
	const character_location: String = 'res://scenes/entities/character/base_character.tscn'
	var character_preload: PackedScene = preload(
		character_location
	)

	var character_instantiate: BaseCharacter = character_preload.instantiate()
	character_instantiate.name = str(id)
	character_instantiate.player_id = id
	character_instantiate.player_name = char_name
	character_instantiate.gender = char_gender
	character_instantiate.position = character_position
	
	character_instantiate.is_local_player = local_player
	character_instantiate.direction = character_instantiate.int_to_direction(
		direction
	)

	var character_sprite: String

	if current_sprite != str(0):
		character_sprite = current_sprite
	else:
		character_sprite = default_sprite

	character_instantiate.set_texture(character_sprite)
	character_spawn_location.add_child(character_instantiate)
