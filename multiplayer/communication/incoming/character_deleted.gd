class_name CharacterDeleted extends RefCounted


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
	var character_list_location: String = '/root/Main/MenuUI/CharacterListUI'
	var character_list_node: CharacterListUI = scene_tree.root.get_node(
		character_list_location
	)
	character_list_node.hide()

	RequestCharacters.new().send()
