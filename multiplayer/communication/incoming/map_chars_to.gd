class_name MapCharsTo extends RefCounted

func handle(message: ServerMessage, scene_tree: SceneTree) -> void:
	var num_chars := message.get_int16()

	for i in range(num_chars):
		var char_id := message.get_int32()
		var char_name := message.get_string()
		var _char_gender := message.get_string()
		var char_map := message.get_int32()
		var char_x := message.get_int32()
		var char_y := message.get_int32()
		var _char_direction := message.get_int8()

		#var character_scene = preload('res://scenes/players/base_character.tscn') as PackedScene
		#var character_instance: BaseCharacter = character_scene.instantiate()
		#character_instance.name = str(char_id)
		#character_instance.player_name = char_name
		#character_instance.player_id = char_id
		#character_instance.is_local_player = false
		#character_instance.position = Vector2(char_x, char_y)
#
		#var current_map_tree := '/root/Main/Game/Maps/' + str(char_map) + '/Chars'
		#var current_map = scene_tree.root.get_node(current_map_tree)
		#if current_map:
			#current_map.add_child(character_instance)
