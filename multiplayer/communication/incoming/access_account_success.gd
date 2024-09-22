class_name AccessAccountSuccess extends RefCounted


func handle(_message : ServerMessage, scene_tree: SceneTree) -> void:
	var access_account_tree := '/root/Main/Menu/AccessAccountUI'
	var footer_tree := '/root/Main/Menu/FooterUI'
	var access_account_ui = scene_tree.root.get_node(access_account_tree) as PanelContainer
	var footer_ui = scene_tree.root.get_node(footer_tree) as MarginContainer

	access_account_ui.hide()
	footer_ui.hide()

	var charList := CharList.new()
	charList.send()
