class_name CreateAccountSuccess extends RefCounted


func handle(_message : ServerMessage, scene_tree: SceneTree) -> void:
    var access_account_tree := '/root/Main/Menu/AccessAccountUI'
    var create_account_tree := '/root/Main/Menu/CreateAccountUI'
    var access_account_ui = scene_tree.root.get_node(access_account_tree) as PanelContainer
    var create_account_ui = scene_tree.root.get_node(create_account_tree) as PanelContainer

    access_account_ui.show()
    create_account_ui.hide()
