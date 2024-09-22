class_name CharSelected extends RefCounted


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
	var char_id := message.get_int32()
	var char_name := message.get_string()
	var _char_gender := message.get_string()
	var char_map := message.get_int32()
	var char_x := message.get_int32()
	var char_y := message.get_int32()
	var _char_direction := message.get_int8()
	
	var map_scene = preload("res://scenes/maps/base_map.tscn") as PackedScene
	var map_instance: BaseMap = map_scene.instantiate()
	var current_map_tree := '/root/Main/Game'
	var current_map = scene_tree.root.get_node(current_map_tree)
	current_map.add_child(map_instance)
	map_instance.spawn_char(char_id, char_name, char_x, char_y)

	var menu_tree := '/root/Main/Menu'
	var menu := scene_tree.root.get_node(menu_tree) as CanvasLayer
	menu.hide()
