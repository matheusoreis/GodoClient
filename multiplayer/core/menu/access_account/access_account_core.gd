class_name AccessAccountCore extends Node


func core(scene_tree: SceneTree) -> void:
	var access_account_node: PanelContainer = scene_tree.root.get_node(
		'/root/Main/MenuUI/AccessAccountUI'
	)
	access_account_node.hide()

	AccessAccountOutgoing.new().send();
