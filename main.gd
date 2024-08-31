extends Control


var _client: WebSocketClient
var _handler: Handler
var _scene_tree: SceneTree
var _alert: AlertUI
var _constants: Constants

var _alert_timer: Timer

func _ready() -> void:
	_scene_tree = get_tree()
	_client = Multiplayer.websocket
	_handler = Handler.new()
	_alert = AlertUI.new()
	_constants = Constants.new()

	_alert_timer = Timer.new()
	_alert_timer.set_wait_time(2)
	_alert_timer.set_one_shot(true)
	add_child(_alert_timer)

	_client.connect_to_host(_constants.host, _constants.port)

	_client.connecting.connect(_on_connecting)
	_client.open.connect(_on_open)
	_client.closing.connect(_on_closing)
	_client.closed.connect(_on_closed)
	_client.received.connect(_on_received)


func _process(_delta) -> void:
	if _client != null:
		_client.poll()


func _on_connecting() -> void:
	_alert.show_alert(_scene_tree, AlertUI.AlertType.INFO, 'Conectando ao servidor...')


func _on_open() -> void:
	_alert.show_alert(_scene_tree, AlertUI.AlertType.INFO, 'Conectado ao servidor!')


func _on_closing() -> void:
	_alert.show_alert(_scene_tree, AlertUI.AlertType.INFO, 'Desconectando do servidor...')


func _on_closed() -> void:
	if not _alert_timer.is_stopped():
		return

	_alert.show_alert(_scene_tree, AlertUI.AlertType.ERROR, 'Não foi possível se conectar ao servidor!')
	_alert_timer.start()


func _on_received(buffer: PackedByteArray) -> void:
	if buffer.size() < 2:
		_client.disconnect_from_host()
		return

	var client_message: ServerMessage = ServerMessage.new(buffer)
	_handler.handle_message(client_message, _scene_tree)
