class_name AccountCreated extends RefCounted


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
	var access_account_location: String = '/root/Main/MenuUI/AccessAccountUI'
	var access_account_node: AccessAccountUI = scene_tree.root.get_node(
		access_account_location
	)
	access_account_node.show()

	var create_account_location: String = '/root/Main/MenuUI/CreateAccountUI'
	var create_account_node: CreateAccountUI = scene_tree.root.get_node(
		create_account_location
	)
	create_account_node.hide()
