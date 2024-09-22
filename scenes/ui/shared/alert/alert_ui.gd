class_name AlertUI extends PanelContainer


@export var timer: Timer
@export var message: Label
@export_range(0, 10) var timeout: float = 1.0


func _ready() -> void:
	timer.wait_time = timeout
	timer.one_shot = true
	timer.start()


func _on_timer_timeout() -> void:
	queue_free()
	

func show_alert(scene_tree: SceneTree, p_message: String) -> void:
	var alert_res := preload("res://scenes/ui/shared/alert/alert_ui.tscn") as PackedScene
	var alert_instantiate := alert_res.instantiate() as AlertUI
	
	var alert_panel_tree := '/root/Main/Shared/AlertLocation/AlertsVBox'

	alert_instantiate.message.text = p_message
	scene_tree.root.get_node(alert_panel_tree).add_child(alert_instantiate)


func _on_button_pressed() -> void:
	queue_free()
