class_name AlertIncoming extends RefCounted


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
	var alert_type := message.get_int8()
	var alert_message := message.get_string()
	var should_disconnect := message.get_int8()

	if should_disconnect == 1:
		Multiplayer.websocket.disconnect_from_host()

	var alert_scene := preload("res://scenes/ui/alert/alert_ui.tscn") as PackedScene
	var alert_panel := alert_scene.instantiate() as AlertUI
	var alert_panel_location := '/root/Main/Shared/AlertLocation/AlertsVBox'
	var alert_vbox := scene_tree.root.get_node(alert_panel_location) as VBoxContainer

	alert_panel.type = alert_type
	alert_panel.message.text = alert_message
	alert_vbox.add_child(alert_panel)
