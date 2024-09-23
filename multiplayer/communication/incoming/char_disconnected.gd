class_name CharDisconnected extends RefCounted


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
	var char_id := message.get_int32()
	
	var current_map_tree := '/root/Main/Game/MapBase/Chars'
	var current_map = scene_tree.root.get_node(current_map_tree)
	
	if current_map:
		var character_instance: BaseCharacter = current_map.get_node_or_null(str(char_id))
		
		if character_instance:
			character_instance.queue_free()
