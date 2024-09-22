class_name CharMoved extends RefCounted

func handle(message: ServerMessage, scene_tree: SceneTree) -> void:
	var char_id := message.get_int32()
	var char_map := message.get_int32()
	var char_x := message.get_int32()
	var char_y := message.get_int32()
	var direction := message.get_int32()

	var current_map_tree := '/root/Main/Game/Maps/' + str(char_map) + '/Chars'
	var current_map = scene_tree.root.get_node(current_map_tree)

	#if current_map:
		#var character_instance: BaseCharacter = current_map.get_node_or_null(str(char_id))
#
		#if character_instance and not character_instance.is_local_player:
			## Atualiza a posição do grid
			#var character_grid_position = Vector2(char_x, char_y)
#
			## Atualiza a posição do personagem remoto
			#character_instance.update_remote_position(character_grid_position, direction)
