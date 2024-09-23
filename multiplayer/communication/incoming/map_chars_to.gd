class_name MapCharsTo extends RefCounted

func handle(message: ServerMessage, scene_tree: SceneTree) -> void:
	var map_helper = MapHelper.new()
	
	var num_chars := message.get_int16()

	for i in range(num_chars):
		var char_id := message.get_int32()
		var char_name := message.get_string()
		var char_gender := message.get_string()
		var char_map := message.get_int32()
		var char_x := message.get_int32()
		var char_y := message.get_int32()
		var _char_direction := message.get_int8()
		
		var map_base = map_helper.ensure_map_is_instantiated(scene_tree)
		map_base.spawn_char(char_id, char_name, char_gender, char_x, char_y, false)
