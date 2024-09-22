class_name AccessAccountSuccess extends RefCounted


func handle(_message : ServerMessage, scene_tree: SceneTree) -> void:
	var access_account_tree := '/root/Main/Menu/AccessAccountUI'
	var access_account_ui = scene_tree.root.get_node(access_account_tree) as PanelContainer

	access_account_ui.hide()

	var charList := CharList.new()
	charList.send()
