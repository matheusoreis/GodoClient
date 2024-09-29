class_name CharacterMoved extends RefCounted


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
	var character_id: int = message.get_int32()
	var character_current_map: int = message.get_int32()
	var character_action: int = message.get_int8()
	var character_map_position_x: int = message.get_int32()
	var character_map_position_y: int = message.get_int32()
	var character_direction: int = message.get_int8()
	var character_velocity_x: int = message.get_int32()
	var character_velocity_y: int = message.get_int32()

	var current_map_node: Node2D = scene_tree.root.get_node_or_null(
		'/root/Main/Game/Map' + str(character_current_map)
	)

	var current_spawns_node: Node2D = scene_tree.root.get_node_or_null(
		'/root/Main/Game/Map' + str(character_current_map) + '/Spawns'
	)

	if current_map_node:
		var remote_character_node: BaseCharacter = current_spawns_node.get_node_or_null(
			str(character_id)
		)

		if remote_character_node and not remote_character_node.is_local_player:
			remote_character_node.update_remote_position(
				character_action,
				character_map_position_x,
				character_map_position_y,
				character_direction,
				character_velocity_x,
				character_velocity_y
			)
