class_name CharSelected extends RefCounted


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
	var char_id := message.get_int32()
	var char_name := message.get_string()
	var char_gender := message.get_string()
	var char_map := message.get_int32()
	var char_x := message.get_int32()
	var char_y := message.get_int32()
	var _char_direction := message.get_int8()
	
	var map_res = preload("res://scenes/maps/map_base.tscn") as PackedScene
	var map_instantiate: MapBase = map_res.instantiate()
	var current_map_tree := '/root/Main/Game'
	var current_map = scene_tree.root.get_node(current_map_tree)
	current_map.add_child(map_instantiate)
	map_instantiate.spawn_char(char_id, char_name, char_gender, char_x, char_y, true)

	var menu_tree := '/root/Main/Menu'
	var in_game_tree := '/root/Main/InGame'
	var menu := scene_tree.root.get_node(menu_tree) as CanvasLayer
	var in_game := scene_tree.root.get_node(in_game_tree) as CanvasLayer
	menu.hide()
	in_game.show()
