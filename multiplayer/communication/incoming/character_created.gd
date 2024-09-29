class_name CharacterCreated extends RefCounted


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
	var create_character_location: String = '/root/Main/MenuUI/CreateCharacterUI'
	var create_character_node: PanelContainer = scene_tree.root.get_node(
		create_character_location
	)
	create_character_node.hide()

	RequestCharacters.new().send()
