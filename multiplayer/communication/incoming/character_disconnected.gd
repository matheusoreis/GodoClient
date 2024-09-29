class_name CharacterDisconnected extends RefCounted


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
	var character_id: int = message.get_int32()
	var character_current_map: int = message.get_int32()

	var current_map_node: Node2D = scene_tree.root.get_node_or_null(
		'/root/Main/Game/Map' + str(character_current_map)
	)

	if current_map_node:
		var current_spawns_node: Node2D = scene_tree.root.get_node_or_null(
			'/root/Main/Game/Map' + str(character_current_map) + '/Spawns'
		)

		var remote_character_node: BaseCharacter = current_spawns_node.get_node_or_null(
			str(character_id)
		)

		if remote_character_node:
			remote_character_node.queue_free()
