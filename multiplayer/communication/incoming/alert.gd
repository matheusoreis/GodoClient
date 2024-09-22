class_name AlertIncoming extends RefCounted


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
	var _alert_type := message.get_int8()
	var alert_message := message.get_string()
	var should_disconnect := message.get_int8()

	if should_disconnect == 1:
		Multiplayer.websocket.disconnect_from_host()

	var alert_scene_res := preload("res://scenes/ui/shared/alert/alert_ui.tscn") as PackedScene
	var alert_instantiate := alert_scene_res.instantiate() as AlertUI
	alert_instantiate.show_alert(scene_tree, alert_message)
