class_name EmoteSent extends RefCounted


func handle(server_message : ServerMessage, scene_tree: SceneTree) -> void:
	var current_emote: int = server_message.get_int8()
	var character_id: int = server_message.get_int32()
	var character_current_map: int = server_message.get_int32()

	var current_map_node: BaseMap = scene_tree.root.get_node_or_null(
		'/root/Main/Game/Map' + str(character_current_map)
	)
	
	if current_map_node:
		var character: BaseCharacter = current_map_node.get_character_by_id(
			character_id
		)
		
		if character:
			character.play_emote(current_emote)
