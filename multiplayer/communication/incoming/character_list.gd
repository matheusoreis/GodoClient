class_name CharacterList extends RefCounted


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
	var character_length: int = message.get_int8()
	var account_characters_size: int = message.get_int8()

	var character_list_location: String = '/root/Main/MenuUI/CharacterListUI'
	var character_list_node: CharacterListUI = scene_tree.root.get_node(
		character_list_location
	)

	var characters: Array = []

	for i in range(character_length):
		var character_id: int = message.get_int32()
		var character_name: String = message.get_string()
		var character_gender: String = message.get_string()
		var character_current_map: int = message.get_int32()
		var character_map_position_x: int = message.get_int32()
		var character_map_position_y: int = message.get_int32()
		var character_direction: int = message.get_int8()

		var character_data: Dictionary = {
			"character_id": character_id,
			"character_name": character_name,
			"character_gender": character_gender,
			"character_current_map": character_current_map,
			"character_map_position_x": character_map_position_x,
			"character_map_position_y": character_map_position_y,
			"character_direction": character_direction,
		}

		characters.append(character_data)


	character_list_node.show()
	character_list_node.update_character_panels(
		characters,
		account_characters_size
	)
