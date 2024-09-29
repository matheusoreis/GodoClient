class_name AlertUI extends PanelContainer


@export var timer: Timer
@export var label: Label
@export_range(0, 10) var timeout: int = 1.0


func _on_timer_timeout() -> void:
	queue_free()


func show_alert(scene_tree: SceneTree, message: String) -> void:
	const alert_location: String = 'res://scenes/ui/shared/alert/alert_ui.tscn'
	var alert_preload: PackedScene = preload(alert_location)
	var alert_instantiate: AlertUI = alert_preload.instantiate()
	alert_instantiate.label.text = message

	var alert_panel_root: String = '/root/Main/SharedUI/AlertLocation/ContentVBox'
	var alert_node := scene_tree.root.get_node(alert_panel_root)

	alert_node.add_child(alert_instantiate)


func _on_button_pressed() -> void:
	queue_free()
