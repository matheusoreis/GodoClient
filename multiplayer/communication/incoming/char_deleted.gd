class_name CharDeleted extends RefCounted


func handle(_message : ServerMessage, scene_tree: SceneTree) -> void:
    var char_list_tree := '/root/Main/Menu/ListCharacterUI'
    var char_list_ui = scene_tree.root.get_node(char_list_tree) as PanelContainer

    char_list_ui.hide()

    var charList := CharList.new()
    charList.send()
