class_name CharacterSelected extends RefCounted


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
	var character_id: int = message.get_int32()
	var character_name: String = message.get_string()
	var character_gender: String = message.get_string()
	var character_current_map: int = message.get_int32()
	var character_map_position_x: int = message.get_int32()
	var character_map_position_y: int = message.get_int32()
	var character_direction: int = message.get_int8()
	var character_default_sprite: String = message.get_string()
	var character_current_sprite: String = message.get_string()

	var character_position: Vector2 = Vector2(
		character_map_position_x,
		character_map_position_y
	)

	var current_map_load: PackedScene = load(
		'res://scenes/maps/list/' + str(character_current_map) + '.tscn'
	)
	var map_instantiate: BaseMap = current_map_load.instantiate()
	map_instantiate.name = 'Map' + str(character_current_map)

	var current_game_location := '/root/Main/Game'
	var current_game_node = scene_tree.root.get_node(current_game_location)
	current_game_node.add_child(map_instantiate)

	map_instantiate.spawn_char(
		character_id,
		character_name,
		character_gender,
		character_position,
		character_direction,
		true,
		character_default_sprite,
		character_current_sprite
	)

	var menu_canvas_location: String = '/root/Main/MenuUI'
	var menu_canvas_node: CanvasLayer = scene_tree.root.get_node(
		menu_canvas_location
	)
	menu_canvas_node.hide()

	var game_canvas_location: String = '/root/Main/GameUI'
	var game_canvas_node: CanvasLayer = scene_tree.root.get_node(
		game_canvas_location
	)
	game_canvas_node.show()
