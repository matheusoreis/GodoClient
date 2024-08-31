class_name AlertUI extends PanelContainer


enum AlertType {
	INFO,
	WARN,
	ERROR
}


@export var timer: Timer
@export var message: Label
@export_range(0, 10) var timeout: float = 1.0
@export var panel_color: Panel
var type: int

func _ready() -> void:
	timer.wait_time = timeout
	timer.one_shot = true
	timer.start()

	var color: Color

	match type:
		AlertType.INFO:
			color = Color('#cfc6b8')
		AlertType.WARN:
			color = Color('#f4b41b')
		AlertType.ERROR:
			color = Color('#e6482e')

	var styleBox: StyleBoxFlat = panel_color.get_theme_stylebox("panel").duplicate(true)
	styleBox.set("bg_color", color)
	panel_color.add_theme_stylebox_override("panel", styleBox)


func _on_timer_timeout() -> void:
	queue_free()


func _on_close_button_pressed() -> void:
	queue_free()


func show_alert(scene_tree: SceneTree, type: AlertType, message: String) -> void:
	var alert_scene := preload("res://scenes/ui/alert/alert_ui.tscn") as PackedScene
	var alert_panel := alert_scene.instantiate() as AlertUI
	var alert_panel_location := '/root/Main/Shared/AlertLocation/AlertsVBox'
	var alert_vbox := scene_tree.root.get_node(alert_panel_location) as VBoxContainer

	alert_panel.type = type
	alert_panel.message.text = message
	alert_vbox.add_child(alert_panel)
