class_name AlertCore extends Node


func core(scene_tree: SceneTree, alert_message: String, should_disconnect: int) -> void:
	if should_disconnect == 1:
		Multiplayer.websocket.disconnect_from_host()
		return

	var alert_preload: PackedScene = preload(
		'res://scenes/ui/shared/alert/alert_ui.tscn'
	)

	var alert_instantiate: AlertUI = alert_preload.instantiate()
	alert_instantiate.show_alert(scene_tree, alert_message)
