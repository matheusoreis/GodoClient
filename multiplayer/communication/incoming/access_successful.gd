class_name AccessSuccessful extends RefCounted


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
	const access_account_location: String = '/root/Main/MenuUI/AccessAccountUI'
	var access_account_node: PanelContainer = scene_tree.root.get_node(
		access_account_location
	)
	access_account_node.hide()

	RequestCharacters.new().send();
