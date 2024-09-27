class_name CharacterCreated extends RefCounted


func handle(_message : ServerMessage, scene_tree: SceneTree) -> void:
	var create_char_tree := '/root/Main/Menu/CreateCharUI'
	var create_char_ui = scene_tree.root.get_node(create_char_tree) as PanelContainer

	create_char_ui.hide()

	var charList := CharacterList.new()
	charList.send()
