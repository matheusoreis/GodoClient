class_name MapCharactersTo extends RefCounted


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
	var map_helper: MapHelper = MapHelper.new()

	var characters_size: int = message.get_int16()
	for i in range(characters_size):
		var character_id: int = message.get_int32()
		var character_name: String = message.get_string()
		var character_gender: String = message.get_string()
		var character_current_map: int = message.get_int32()
		var character_map_position_x: int = message.get_int32()
		var character_map_position_y: int = message.get_int32()
		var character_direction: int = message.get_int8()
		var character_default_sprite: String = message.get_string()
		var character_current_sprite: String = message.get_string()

		var current_map: BaseMap = map_helper.ensure_map_is_instantiated(
			scene_tree, character_current_map
		)

		var character_position: Vector2 = Vector2(
			character_map_position_x,
			character_map_position_y
		)

		current_map.spawn_char(
			character_id,
			character_name,
			character_gender,
			character_position,
			character_direction,
			false,
		character_default_sprite,
		character_current_sprite
		)
